# Dotfiles

This repository contains my personal configuration files (dotfiles) and a management system for various applications and system tools.

## Overview

This project provides a declarative approach to system configuration on Arch Linux, combining package management with configuration deployment.

### Declarative Package Management
The project utilizes **decman** for declarative package management on Arch Linux, ensuring that the required system packages are consistently installed and managed.

### Configuration Setup
In addition to package management, the project automates the setup and deployment of configuration files (dotfiles) across the system, ensuring a reproducible environment.

## Structure

- `configs/`: Actual configuration files for:
  - **Alacritty**: Terminal emulator
  - **Blesh**: Bash line editor
  - **Git**: Version control settings
  - **GnuPG**: Encryption and signing
  - **Niri**: Wayland compositor
  - **Neovim**: Text editor
  - **Shell**: Bash and input configuration
  - **Starship**: Cross-shell prompt
  - **Tmux**: Terminal multiplexer

- `modules/`: Python modules used to manage and deploy these configurations.
- `zenaio.py`: Main entry point or management script for the dotfiles.
- `pyproject.toml` & `uv.lock`: Python project dependencies managed by `uv`.

## Installation & Management

This repository uses a Python-based management system. 

### Prerequisites
- Python 3
- [uv](https://github.com/astral-sh/uv) (recommended for dependency management)

### Usage
Run the management script:
```bash
sudo decman --source zenaio.py
```

## License
Private / Personal use.