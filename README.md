# Dotfiles

This repository contains personal configuration for tools like Fish, tmux, Neovim, LazyGit, and more. Each directory under the repo mirrors the structure expected inside `~/.config`, and the helper scripts take care of provisioning dependencies (requires `git` up front) and linking the configs.

## Usage

```bash
git clone https://github.com/aehrlich1/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The `install.sh` script first runs `setup-remote.sh` to install required packages (APT, Homebrew, CLI tools, etc.) and then invokes `link-configs.sh` to symlink every configuration directory from the repo into `~/.config`.

For machine-specific Fish tweaks, add them to `fish/conf.d/config.local.fish`; the directory is already sourced by Fish, but the file is ignored so local overrides stay untracked.
