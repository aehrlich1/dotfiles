#!/usr/bin/env bash
set -euo pipefail

if [[ $# -gt 0 ]]; then
  echo "Error: setup-remote.sh takes no arguments (got: $*)." >&2
  echo "The AI CLIs are now chosen interactively during setup." >&2
  exit 1
fi

# Optional AI CLIs offered during setup, as "label:npm package".
AI_TOOLS=(
  "Claude Code:@anthropic-ai/claude-code"
  "Codex:@openai/codex"
  "Gemini CLI:@google/gemini-cli"
)

# Ask a yes/no question. An empty answer, or no terminal to ask on, means yes.
prompt_yes_no() {
  local question="$1" reply
  if [[ ! -t 0 ]]; then
    echo "${question} [Y/n] y (no terminal attached, using the default)"
    return 0
  fi
  while true; do
    read -r -p "${question} [Y/n] " reply || reply=""
    case "$reply" in
    "" | [Yy] | [Yy][Ee][Ss]) return 0 ;;
    [Nn] | [Nn][Oo]) return 1 ;;
    *) echo "Please answer y or n." ;;
    esac
  done
}

# Ensure apt is available
if ! command -v apt &>/dev/null; then
  echo "Error: apt is not available on this system." >&2
  exit 1
fi

# Ask up front so the rest of the install can run unattended.
SELECTED_AI_TOOLS=()
echo "Optional AI CLIs:"
for tool in "${AI_TOOLS[@]}"; do
  if prompt_yes_no "  Install ${tool%%:*}?"; then
    SELECTED_AI_TOOLS+=("$tool")
  fi
done

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

# Source updated .bashrc to pick up any changes (if it exists) without tripping set -u
if [[ -f ~/.bashrc ]]; then
  set +u
  source ~/.bashrc
  set -u
fi

echo "Installing packages..."
BREW_PACKAGES=(
  duf
  dust
  eza
  fastfetch
  fd
  fish
  fzf
  gh
  git
  glow
  htop
  jq
  lazydocker
  lazygit
  ncdu
  neovim
  node
  nvtop
  ripgrep
  ruff
  sevenzip
  tlrc
  tree-sitter-cli
  tmux
  uv
  visidata
  wget
  yazi
  zoxide
)
brew install "${BREW_PACKAGES[@]}"

if ((${#SELECTED_AI_TOOLS[@]} > 0)); then
  for tool in "${SELECTED_AI_TOOLS[@]}"; do
    echo "Installing ${tool%%:*}..."
    npm install -g "${tool##*:}"
  done
else
  echo "No AI CLIs selected."
fi

# Install turm
echo "Installing turm..."
uv tool install turm

# Install Tmux plugin manager
echo "Installing Tmux Plugin Manager..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 2>/dev/null || echo "TPM already installed."

echo "Done."
