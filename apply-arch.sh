#!/bin/bash

original_dir=$(pwd)
cd ~/.dotfiles

# Check for remote changes
git remote update
local_commits=$(git rev-parse HEAD)
remote_commits=$(git rev-parse @{u})

if [ "$local_commits" != "$remote_commits" ]; then
    echo "⚠️  Remote changes detected - run 'git pull' to integrate them"
    cd "$original_dir"
    exit 1
fi

build_success=0
nix build ~/.dotfiles#homeConfigurations.archie.activationPackage --impure || build_success=1

if [ $build_success -eq 0 ]; then
    ~/.dotfiles/result/activate
    hyprctl reload
    git add .
    git commit -a
    git push
else
    echo "❌ Nix build failed"
fi

cd "$original_dir"