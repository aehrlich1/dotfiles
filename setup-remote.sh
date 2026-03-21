#!/usr/bin/env bash
set -euo pipefail

# Ensure apt is available
if ! command -v apt &>/dev/null; then
  echo "Error: apt is not available on this system." >&2
  exit 1
fi

echo "Updating apt and installing prerequisites..."
sudo apt update && sudo apt install -y curl git

# Install Homebrew
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add brew to PATH for Linux (default Homebrew location)
  test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
  test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

  # Add brew to .bashrc only if not already present (idempotent)
  BREW_LINE="eval \"\$($(brew --prefix)/bin/brew shellenv)\""
  grep -qxF "$BREW_LINE" ~/.bashrc 2>/dev/null || echo "$BREW_LINE" >>~/.bashrc
else
  echo "Homebrew already installed."
fi

# Ensure ~/.local/bin is on PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  echo "Adding ~/.local/bin to PATH in ~/.bashrc..."
  echo 'export PATH="$HOME/.local/bin:$PATH"' >>~/.bashrc
  export PATH="$HOME/.local/bin:$PATH"
fi

# Source updated .bashrc to pick up any changes
source ~/.bashrc

echo "Installing packages..."
brew install duckdb duf dust eza fastfetch fd fish fzf gh htop jq lazydocker lazygit neovim node ripgrep ruff sevenzip tree-sitter-cli tmux uv visidata wget yazi zoxide

# Install Claude Code
echo "Installing Claude Code..."
npm install -g @anthropic-ai/claude-code

# Install OpenAI Codex
echo "Installing Codex..."
npm install -g @openai/codex

# Install Gemini CLI
echo "Installing Gemini CLI..."
npm install -g @google/gemini-cli

# Install turm
echo "Installing turm..."
uv tool install turm

# Install Tmux plugin manager
echo "Installing Tmux Plugin Manager..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 2>/dev/null || echo "TPM already installed."

echo "Done."

# TODO: conda (though that should be a separate script, or be set as a flag during installation)
# TODO: configure fish shell as login shell
# TODO: install nvtop (if GPU is found)
# TODO: add option to not install AI tools
