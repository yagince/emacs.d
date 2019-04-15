(use-package go-mode
  :defer t
  :mode (("\\.go\\'" . go-mode))
  :config
  (add-hook 'go-mode-hook
            '(lambda ()
               (company-mode t)
               (dumb-jump-mode t)
               (yas-minor-mode t)
               (setq tab-width 2)
               ))
  (setq gofmt-command "goimports")
  (bind-keys :map go-mode-map
             ("C-c C-r" . go-remove-unused-imports)
             ("M-." . godef-jump)
             ("M-," . pop-tag-mark)
             ("C-c C-i" . go-import-add)
             )
  (add-hook 'before-save-hook 'gofmt-before-save)
  (use-package go-eldoc
    :config
    (add-hook 'go-mode-hook 'go-eldoc-setup))
  )
