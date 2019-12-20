;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq gc-cons-threshold (* 128 1024 1024))

;;cask
;;(require 'cask "/usr/local/opt/cask/cask.el")
(require 'cask "~/.cask/cask.el")
(cask-initialize "~/.emacs.d")

(let ((envs '("PATH" "RUST_SRC_PATH")))
  (exec-path-from-shell-copy-envs envs))

(setenv "PATH" (concat (expand-file-name "~/.rbenv/shims/ruby") (getenv "PATH")))

(yas-global-mode 1)
 
(require 'init-loader)
(init-loader-load "~/.emacs.d/init-loader")
(setq init-loader-byte-compile t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d6922c974e8a78378eacb01414183ce32bc8dbf2de78aabcc6ad8172547cb074" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "211bb9b24001d066a646809727efb9c9a2665c270c753aa125bace5e899cb523" default)))
 '(help-at-pt-display-when-idle (quote (flymake-overlay)) nil (help-at-pt))
 '(help-at-pt-timer-delay 0.9)
 '(package-selected-packages
   (quote
    (dumb-jump-mode yascroll yaml-mode wgrep-helm wgrep-ag web-mode vue-mode use-package toml-mode textile-mode swiper splitjoin smartrep slim-mode sequential-command selected scss-mode scratch-log rvm rustic ruby-refactor ruby-hash-syntax ruby-end rubocop robe ripgrep rg recentf-ext rainbow-mode rainbow-delimiters racer quickrun powerline popwin php-mode perlbrew open-junk-file nginx-mode neotree multiple-cursors magit lua-mode lsp-mode js2-mode ivy-rich init-loader highlight-symbol helm-tramp helm-smex helm-open-github helm-ag haskell-mode haml-mode goto-chg golint go-eldoc go-autocomplete fzf fuzzy flymake-go flycheck-rust flycheck-pos-tip floobits expand-region exec-path-from-shell erlang ensime enh-ruby-mode eglot dumb-jump dockerfile-mode docker cyberpunk-theme csharp-mode coffee-mode cask anzu ansible alchemist ag add-node-modules-path actionscript-mode)))
 '(safe-local-variable-values (quote ((encoding . utf-8))))
 '(send-mail-function (quote mailclient-send-it)))
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
