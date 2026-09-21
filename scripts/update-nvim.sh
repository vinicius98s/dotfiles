#!/bin/bash

set -e

INSTALL_DIR="/opt"
NVIM_DIR="$INSTALL_DIR/nvim-linux-x86_64"
TARBALL="nvim-linux-x86_64.tar.gz"
REPO="neovim/neovim"

get_latest_version() {
  curl -s "https://api.github.com/repos/$REPO/releases/latest" \
    | awk -F=":" -v RS="," '$1~/"tag_name"/ {print}' \
    | sed 's/"tag_name": //g' \
    | sed 's/[^"]*"\([^"]*\)".*/\1/' \
    | xargs echo -n
}

current_version=$(nvim --version 2>/dev/null | head -1 | awk '{print $2}')
latest_version=$(get_latest_version)

echo "Current version: ${current_version:-not installed}"
echo "Latest version:  $latest_version"

if [ "$current_version" = "$latest_version" ]; then
  echo "Neovim is already up to date."
  exit 0
fi

echo "Updating Neovim to $latest_version..."

curl -L -o "/tmp/$TARBALL" "https://github.com/$REPO/releases/latest/download/$TARBALL"
sudo rm -rf "$NVIM_DIR"
sudo tar -C "$INSTALL_DIR" -xzf "/tmp/$TARBALL"
rm -f "/tmp/$TARBALL"

echo "Neovim updated to $(nvim --version | head -1)"
