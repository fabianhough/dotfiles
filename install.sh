#!/bin/bash


DOTFILES="$(cd "$(dirname "$0")" && pwd)"
MINIMAL=false


# == help ==
show_help() {
  echo
  echo "Usage: ./install.sh [options]"
  echo
  echo "Options:"
  echo "  --help       Displays this help message"
  echo "  --minimal    Skips GUI-dependent packages (fonts, themes)"
  echo
}


# == pkg install ==
install_pkgs() {
  echo "Installing packages..."
  local packages=(zsh starship neovim zellij)
  
  # utilities
  packages+=(rsync eza fzf btop)

  if [[ "$MINIMAL" == false ]]; then
    packages+=(wl-clipboard alacritty ttf-iosevkaterm-nerd ttf-firacode-nerd)
  fi

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
  ln -sf "$DOTFILES/zsh/.zsh_alias" "$HOME/.zsh_alias"

  # neovim
  mkdir -p "$HOME/.config/nvim"
  ln -sf "$DOTFILES/nvim/init.lua" "$HOME/.config/nvim/init.lua"

  # zellij
  mkdir -p "$HOME/.config/zellij"
  ln -sf "$DOTFILES/zellij/config.kdl" "$HOME/.config/zellij/config.kdl"

  if [[ "$MINIMAL" == false ]]; then
    # starship - themed
    ln -sf "$DOTFILES/starship/starship-catppuccin.toml" "$HOME/.config/starship.toml"

    # alacritty
    mkdir -p "$HOME/.config/alacritty"
    ln -sf "$DOTFILES/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
    ln -sf "$DOTFILES/alacritty/color-theme-catppucchin-macchiato.toml" "$HOME/.config/alacritty/color-theme-catppucchin-macchiato.toml"
  else
    # starship - baseline
    ln -sf "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"
  fi
}


# == processing options ==
while [[ $# -gt 0 ]]; do
  case "$1" in
    --help)       show_help; exit 0 ;;
    --minimal)    MINIMAL=true; shift ;;
    *)            echo "Unknown option: $1"; show_help; exit 1;;
  esac
done


# == execute ==
echo
echo "Starting dotfile installation..."
echo
install_pkgs
echo
link_dotfiles
echo
echo "Complete."
