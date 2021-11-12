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
(setq gc-cons-threshold (* 128 1024 1024))

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

(leaf exec-path-from-shell
  :ensure t
  :defun (exec-path-from-shell-initialize)
  :custom
  ((exec-path-from-shell-variables           . '("RUST_SRC_PATH"
                                                 "PATH")))
  :config
  (exec-path-from-shell-initialize)
  )

(leaf init-loader
  :ensure t
  :config
  (init-loader-load "~/.emacs.d/init-loader")
  )

(leaf ace
  :config
  (leaf ace-jump-mode
    :ensure t
    )
  (leaf ace-window
    :ensure t
    :bind (
           ("C-x a" . ace-window)
           )
    :custom
    (aw-keys . '(?a ?b ?k ?l ?g ?h ?j ?k))
    )
  )

(leaf projectile
  :ensure t
  :custom
  ((projectile-mode . +1))
  )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(all-the-icons-scale-factor 1.0)
 '(aw-keys '(97 98 107 108 103 104 106 107))
 '(company-box-doc-enable nil)
 '(company-box-icons-alist 'company-box-icons-all-the-icons)
 '(company-idle-delay 0)
 '(company-minimum-prefix-length 1)
 '(company-transformers '(company-sort-by-occurrence))
 '(doom-modeline-buffer-file-name-style 'truncate-with-project)
 '(doom-modeline-icon t)
 '(doom-modeline-major-mode-icon nil)
 '(doom-modeline-minor-modes nil)
 '(dumb-jump-mode t)
 '(dumb-jump-selector 'ivy)
 '(dumb-jump-use-visible-window nil)
 '(exec-path-from-shell-variables '("RUST_SRC_PATH" "PATH"))
 '(highlight-indent-guides-auto-enabled t t)
 '(highlight-indent-guides-method 'character t)
 '(highlight-indent-guides-responsive t t)
 '(imenu-list-position 'left t)
 '(imenu-list-size 30 t)
 '(ivy-prescient-retain-classic-highlighting t)
 '(lsp-prefer-flymake 'flymake t)
 '(lsp-print-io nil t)
 '(lsp-print-performance nil t)
 '(lsp-response-timeout 5 t)
 '(lsp-trace nil t)
 '(lsp-ui-doc-header t)
 '(lsp-ui-doc-include-signature t)
 '(lsp-ui-doc-max-height 30)
 '(lsp-ui-doc-max-width 150)
 '(lsp-ui-doc-position 'at-point)
 '(lsp-ui-doc-use-childframe nil)
 '(lsp-ui-doc-use-webkit t)
 '(lsp-ui-imenu-enable nil)
 '(lsp-ui-imenu-kind-position 'top)
 '(lsp-ui-peek-enable t)
 '(lsp-ui-peek-fontify 'on-demand)
 '(lsp-ui-peek-list-width 50)
 '(lsp-ui-peek-peek-height 20)
 '(lsp-ui-sideline-enable nil)
 '(package-archives
   '(("org" . "https://orgmode.org/elpa/")
     ("melpa" . "https://melpa.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/")))
 '(package-selected-packages
   '(flymake-eslint projectile rspec-mode add-node-modules-path prettier pretiier ansible ansible-mode yasnippet yaml-mode web-mode vue-mode volatile-highlights undo-tree toml-mode terraform-mode smart-jump slim-mode scss-mode scratch-log rvm rustic ruby-refactor ruby-hash-syntax ruby-end rg rainbow-mode rainbow-delimiters quickrun protobuf-mode open-junk-file nginx-mode neotree multiple-cursors mozc magit macrostep lsp-ui leaf-tree leaf-convert json-mode ivy-prescient ivy-hydra init-loader highlight-symbol highlight-indent-guides haml-mode graphql-mode goto-chg go-eldoc git-gutter+ fzf flycheck expand-region exec-path-from-shell erlang elixir-mode el-get eglot doom-modeline dockerfile-mode cyberpunk-theme csharp-mode counsel company-box blackout bind-key anzu all-the-icons-ivy-rich all-the-icons-ivy ace-window ace-jump-mode))
 '(prescient-aggressive-file-save t)
 '(prescient-save-file "~/.emacs.d/prescient")
 '(rbenv-installation-dir "~/.rbenv")
 '(rustic-format-on-save t t)
 '(rustic-format-trigger nil t)
 '(rustic-lsp-format t t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'set-goal-column 'disabled nil)
(put 'scroll-left 'disabled nil)
