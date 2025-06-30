#!/usr/bin/env sh
set -Eeuo pipefail

original_dir=$(pwd)
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
  cd "$original_dir"
  exit 1
fi

build_success=0
nix build .#darwinConfigurations.ssanchez.system --impure -L -v || build_success=1

if [ $build_success -eq 0 ]; then
  sudo ./result/sw/bin/darwin-rebuild switch --flake .#ssanchez --impure -L -v
  if [ $no_git -eq 0 ]; then
    git add .
    git commit -a
    git push
  fi
else
  echo "❌ Nix build failed"
fi

cd "$original_dir"
