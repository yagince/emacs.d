;; <leaf-install-code>
(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))
;; </leaf-install-code>

(leaf leaf
  :config
  (leaf leaf-convert :ensure t)
  (leaf leaf-tree
    :ensure t
    :custom ((imenu-list-size . 30)
             (imenu-list-position . 'left))))

(leaf macrostep
  :ensure t
  :bind (("C-c e" . macrostep-expand)))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)
;;(debug-on-entry 'package-initialize)
(setq gc-cons-threshold (* 128 1024 1024))

;;cask
(require 'cask "/usr/local/opt/cask/cask.el")
;;(require 'cask "~/.cask/cask.el")
(cask-initialize "~/.emacs.d")

(require 'use-package)

(let ((envs '("PATH" "RUST_SRC_PATH")))
  (exec-path-from-shell-copy-envs envs))

;; (setenv "PATH" (concat (expand-file-name "~/.rbenv/shims/ruby") (getenv "PATH")))

(yas-global-mode 1)

(require 'init-loader)
(init-loader-load "~/.emacs.d/init-loader")
;; (setq init-loader-byte-compile t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(all-the-icons-scale-factor 1.0)
 '(ansi-color-names-vector
   ["#000000" "#8b0000" "#00ff00" "#ffa500" "#7b68ee" "#dc8cc3" "#93e0e3" "#dcdccc"])
 '(custom-safe-themes
   '("b89a4f5916c29a235d0600ad5a0849b1c50fab16c2c518e1d98f0412367e7f97" "d6922c974e8a78378eacb01414183ce32bc8dbf2de78aabcc6ad8172547cb074" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "211bb9b24001d066a646809727efb9c9a2665c270c753aa125bace5e899cb523" default))
 '(doom-modeline-buffer-file-name-style 'truncate-with-project t)
 '(doom-modeline-icon t t)
 '(doom-modeline-major-mode-icon nil t)
 '(doom-modeline-minor-modes nil t)
 '(fci-rule-color "#383838")
 '(help-at-pt-display-when-idle '(flymake-overlay) nil (help-at-pt))
 '(help-at-pt-timer-delay 0.9)
 '(imenu-list-position 'left t)
 '(imenu-list-size 30 t)
 '(package-archives
   '(("org" . "https://orgmode.org/elpa/")
     ("melpa" . "https://melpa.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/")))
 '(package-selected-packages
   '(blackout el-get yaml-mode use-package toml-mode textile-mode slim-mode sequential-command scss-mode scratch-log rvm ruby-refactor ruby-hash-syntax ruby-end rubocop rainbow-delimiters nginx-mode neotree multiple-cursors magit lua-mode lsp-mode js2-mode ivy-rich init-loader highlight-symbol helm-tramp helm-smex helm-open-github helm-ag haskell-mode haml-mode goto-chg golint go-eldoc go-autocomplete fzf fuzzy flymake-go flycheck-rust flycheck-pos-tip floobits exec-path-from-shell erlang ensime enh-ruby-mode eglot dockerfile-mode docker cyberpunk-theme csharp-mode coffee-mode cask ansible alchemist ag add-node-modules-path actionscript-mode))
 '(safe-local-variable-values '((encoding . utf-8)))
 '(send-mail-function 'mailclient-send-it))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(magit-diff-added ((t (:background "black" :foreground "green"))))
 '(magit-diff-added-highlight ((t (:background "white" :foreground "green"))))
 '(magit-diff-removed ((t (:background "black" :foreground "blue"))))
 '(magit-diff-removed-hightlight ((t (:background "white" :foreground "blue"))))
 '(magit-hash ((t (:foreground "red")))))
(put 'set-goal-column 'disabled nil)
