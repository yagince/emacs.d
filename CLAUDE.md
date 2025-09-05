# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Emacs configuration repository fully migrated from Leaf to use-package (built into Emacs 29+). The configuration is heavily modularized with extensive customization for various programming languages and development tools. GitHub packages are installed via package-vc using use-package's `:vc` keyword.

## Key Files and Structure

- **init.el**: Main configuration file containing all Emacs customizations organized by functionality (migrated to use-package)
- **init-leaf-backup.el**: Backup of the original Leaf-based configuration before migration
- **early-init.el**: Minimal early initialization to disable package loading at startup
- **custom.el**: Auto-generated custom variables (not tracked in git)
- **snippets/**: YASnippet templates organized by mode (web-mode, vue-mode, rustic-mode, etc.)
- **themes/**: Custom theme files (pastels-on-dark-theme.el, githublike-theme.el)
- **el-get/**: Legacy directory from pre-migration (not used by current config)

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
- Uses **use-package** as the primary package management system (Emacs 29+)
- Packages are installed from MELPA, GNU, NonGNU, and Org archives
- **package-vc** via `use-package :vc` is used for GitHub packages (e.g., copilot.el, mozc-el-extensions)

## Configuration Architecture

### Package Management
- **use-package**: Main package declaration and configuration system (all packages)
- **package-vc**: Fetch GitHub packages via `:vc` (no el-get/Leaf)

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
- **Copilot**: GitHub Copilot integration via `use-package :vc`
- **Claude Code IDE**: Integration for Claude Code with vterm backend
- **Mozc**: Japanese input method (Linux only)
- **DDskk**: Alternative Japanese input method

## Development Workflow

### Testing Configuration Changes
1. Edit init.el
2. Evaluate changes with `M-x eval-buffer` or restart Emacs
3. Test functionality in relevant mode

### Adding New Packages
Add a new use-package declaration in init.el following the existing pattern:
```elisp
(use-package package-name
  :ensure t
  :demand t  ; if you need immediate loading (replaces leaf's :require t)
  :custom
  (variable-name value)  ; replaces leaf's :setq
  :config
  ;; configuration here
  :hook
  (mode-name . function-name)  ; hook configuration
  :bind
  ("key" . command))  ; key bindings
```

For packages hosted on GitHub, use `:vc` with use-package:
```elisp
(use-package package-name
  :vc (:fetcher github :repo "owner/repo" :rev :newest))
```

### Debugging
- Check `*Messages*` buffer for errors
- Use `M-x toggle-debug-on-error` for detailed stack traces
- Package-specific issues often require checking their GitHub issues

## Migration Notes (Leaf to use-package)

### Key Differences
| Leaf | use-package | Notes |
|------|-------------|-------|
| `:require t` | `:demand t` | Force immediate loading |
| `:setq` | `:custom` | Set custom variables |
| `:global-minor-mode` | `:config` + explicit call | Enable global modes |
| `:hook (mode-hook . func)` | `:hook (mode . func)` | Hook syntax (remove -hook suffix) |
| `:preface` | `:init` | Code before package loads |

### Packages Still Using Leaf
None. Leaf has been fully removed from the active configuration.

### Testing After Changes
After making configuration changes:
1. Run `M-x eval-buffer` to reload configuration
2. Check `*Messages*` for any errors
3. Test specific functionality related to changed packages
4. Restart Emacs if experiencing issues with package loading order
