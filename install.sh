#!/bin/bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$script_dir/config"

# Neovim
ln -s "$DOTFILES_DIR/nvim/" "$HOME/.config"

# WezTerm
ln -s "$DOTFILES_DIR/wezterm/wezterm.lua" "$HOME/.wezterm.lua"

# SketchyBar
ln -s "$DOTFILES_DIR/sketchybar" "$HOME/.config/sketchybar"

# yabai
ln -s "$DOTFILES_DIR/yabai/yabairc" "$HOME/.yabairc"

# zsh
ln -s "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
