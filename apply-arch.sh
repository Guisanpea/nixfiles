#!/bin/bash

# Set up trap to always return to original directory
original_dir=$(pwd)
trap "cd \"$original_dir\"" EXIT

no_git=0
while [ $# -gt 0 ]; do
    case "$1" in
        --no-git) no_git=1 ;;
    esac
    shift
done

cd ~/.dotfiles

# Check for remote changes
git remote update
local_commits=$(git rev-parse HEAD)
remote_commits=$(git rev-parse @{u})

if [ "$local_commits" != "$remote_commits" ]; then
    echo "⚠️  Remote changes detected - run 'git pull' to integrate them"
    exit 1
fi

build_success=0
nix build ~/.dotfiles#homeConfigurations.archie.activationPackage --impure || build_success=1

[ $build_success -ne 0 ] && { echo "❌ Nix build failed"; exit 1; }

activate_success=0
~/.dotfiles/result/activate || activate_success=1

[ $activate_success -ne 0 ] && { echo "❌ Activation failed"; exit 1; }

hyprctl reload

# Only perform git operations if no_git is 0
[ $no_git -eq 0 ] && {
    git add .
    git commit -a
    git push
}