#!/usr/bin/env sh
set -Eeuo pipefail

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
nix build .#darwinConfigurations.ssanchez.system --impure -L -v || build_success=1

if [ $build_success -eq 0 ]; then
  ./result/sw/bin/darwin-rebuild switch --flake .#ssanchez --impure -L -v
  git add .
  git commit -a
  git push
else
  echo "❌ Nix build failed"
fi

cd "$original_dir"
