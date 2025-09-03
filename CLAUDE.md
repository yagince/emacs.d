# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Emacs configuration repository that has been migrated from Leaf to use-package (built into Emacs 29+). The configuration is heavily modularized with extensive customization for various programming languages and development tools. A small number of packages remain using Leaf for technical compatibility reasons.

## Key Files and Structure

- **init.el**: Main configuration file containing all Emacs customizations organized by functionality (migrated to use-package)
- **init-leaf-backup.el**: Backup of the original Leaf-based configuration before migration
- **early-init.el**: Minimal early initialization to disable package loading at startup
- **custom.el**: Auto-generated custom variables (not tracked in git)
- **snippets/**: YASnippet templates organized by mode (web-mode, vue-mode, rustic-mode, etc.)
- **themes/**: Custom theme files (pastels-on-dark-theme.el, githublike-theme.el)
- **el-get/**: El-get managed packages (still used for copilot integration)

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
- Uses **use-package** as the primary package management system (built into Emacs 29+)
- Packages are installed from MELPA, GNU, NonGNU, and Org archives
- **Leaf** remains for specific packages requiring el-get integration (copilot) and Linux-only packages (mozc)
- **El-get** is used for packages not available in standard repositories (e.g., copilot.el from GitHub)

## Configuration Architecture

### Package Management
- **use-package**: Main package declaration and configuration system (86+ packages migrated)
- **Leaf**: Retained for el-get integration and Linux-specific packages (6 packages)
  - leaf-keywords, leaf-convert, leaf-tree (infrastructure)
  - mozc, *user-mozc-tool (Linux-only Japanese input)
  - copilot (requires el-get integration)
- **El-get**: Used for packages from GitHub (e.g., mozc-el-extensions, copilot.el)

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

For packages requiring el-get, continue using Leaf:
```elisp
(leaf package-name
  :el-get (package-spec)
  :require t)
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
The following packages remain on Leaf for technical reasons:
1. **leaf-keywords, leaf-convert, leaf-tree**: Infrastructure for el-get support
2. **mozc, *user-mozc-tool**: Linux-only, not used on macOS
3. **copilot**: Requires el-get to fetch from GitHub

### Testing After Changes
After making configuration changes:
1. Run `M-x eval-buffer` to reload configuration
2. Check `*Messages*` for any errors
3. Test specific functionality related to changed packages
4. Restart Emacs if experiencing issues with package loading order