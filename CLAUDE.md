# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Emacs configuration repository using the Leaf package management system. The configuration is heavily modularized with extensive customization for various programming languages and development tools.

## Key Files and Structure

- **init.el**: Main configuration file (1642 lines) containing all Emacs customizations organized by functionality
- **early-init.el**: Minimal early initialization to disable package loading at startup
- **snippets/**: YASnippet templates organized by mode (web-mode, vue-mode, rustic-mode, etc.)
- **themes/**: Custom theme files (pastels-on-dark-theme.el, githublike-theme.el)
- **el-get/**: El-get managed packages

## Common Development Tasks

### Running Emacs with this configuration
```bash
emacs --init-directory ~/.emacs.d
```

### Evaluating configuration changes
```elisp
M-x eval-buffer    # Evaluate entire init.el
C-x C-e            # Evaluate expression at point
```

### Package management
- Uses Leaf as the primary package management system
- Packages are installed from MELPA, GNU, NonGNU, and Org archives
- El-get is used for some packages not available in standard repositories

## Configuration Architecture

### Package Management
- **Leaf**: Main package declaration and configuration system
- **El-get**: Used for packages from GitHub (e.g., mozc-el-extensions, copilot.el)
- **use-package**: Used for claude-code-ide configuration

### Key Bindings Philosophy
- `C-h` remapped to backward-delete-char
- `C-x m` for Magit status
- `C-x n` for Treemacs
- `M-SPC` for input method toggle (Mozc on Linux)
- Heavy use of Ivy/Counsel for completion

### Language Support
Primary language modes configured:
- **Ruby**: ruby-mode, rspec-mode, rbenv integration
- **Rust**: rustic-mode with eglot
- **Go**: go-mode with LSP
- **Web**: web-mode for JS/TS/JSX/TSX with prettier
- **Python**: python-mode
- **Markdown**: gfm-mode with native code block highlighting

### IDE Features
- **Completion**: Company-mode globally enabled
- **Navigation**: dumb-jump, smart-jump
- **Version Control**: Magit
- **File Explorer**: Treemacs
- **Fuzzy Finding**: Ivy, Counsel, FZF
- **Linting**: Flycheck
- **LSP**: Both lsp-mode and eglot configured (eglot preferred for Rust)

### UI Customization
- Theme: modus-vivendi-deuteranopia (F5 to toggle themes)
- Font: HackGen-16 with Apple Color Emoji support
- Frame transparency: 80%
- Line numbers: Enabled globally
- Modeline: doom-modeline

### Special Integrations
- **Copilot**: GitHub Copilot integration via el-get
- **Claude Code IDE**: Integration for Claude Code with vterm backend
- **Mozc**: Japanese input method (Linux only)
- **DDskk**: Alternative Japanese input method

## Development Workflow

### Testing Configuration Changes
1. Edit init.el
2. Evaluate changes with `M-x eval-buffer` or restart Emacs
3. Test functionality in relevant mode

### Adding New Packages
Add a new Leaf declaration in init.el following the existing pattern:
```elisp
(leaf package-name
  :ensure t
  :config
  ;; configuration here
  )
```

### Debugging
- Check `*Messages*` buffer for errors
- Use `M-x toggle-debug-on-error` for detailed stack traces
- Package-specific issues often require checking their GitHub issues