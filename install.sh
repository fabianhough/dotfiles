#!/bin/bash


DOTFILES="$(cd "$(dirname "$0")" && pwd)"


# == pkg install ==
install_pkgs() {
  echo "Installing packages..."
  local packages=(zsh starship)

  if command -v pacman &>/dev/null; then
    sudo pacman -S --needed "${packages[@]}"
  elif command -v apt &>/dev/null; then
    sudo apt update && sudo apt install -y "${packages[@]}"
  else
    echo "Package manager unsupported."
    exit 1
  fi
}


# == symlink ==
link_dotfiles() {
  echo "Linking dotfiles..."
  
  # zsh
  ln -sf "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"

  # starship
  ln -sf "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"
}


# == execute ==
echo "Starting dotfile installation..."
echo
install_pkgs
echo
link_dotfiles
echo
echo "Complete."
