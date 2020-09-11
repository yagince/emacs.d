;; (use-package go-mode
;;   :defer t
;;   :mode (("\\.go\\'" . go-mode))
;;   :config
;;   (add-hook 'go-mode-hook
;;             '(lambda ()
;;                (company-mode t)
;;                (dumb-jump-mode t)
;;                (yas-minor-mode t)
;;                (setq tab-width 2)
;;                ))
;;   (setq gofmt-command "goimports")
;;   (bind-keys :map go-mode-map
;;              ("C-c C-r" . go-remove-unused-imports)
;;              ("M-." . godef-jump)
;;              ("M-," . pop-tag-mark)
;;              ("C-c C-i" . go-import-add)
;;              )
;;   (add-hook 'before-save-hook 'gofmt-before-save)
;;   (use-package go-eldoc
;;     :config
;;     (add-hook 'go-mode-hook 'go-eldoc-setup))
;;   )
(leaf go-mode
  :ensure t
  :mode ("\\.go\\'")
  :config
  (with-eval-after-load 'go-mode
    (add-hook 'go-mode-hook
              '(lambda nil
                 (company-mode t)
                 (dumb-jump-mode t)
                 (yas-minor-mode t)
                 (setq tab-width 2)))
    (setq gofmt-command "goimports")
    (progn
      (bind-key "C-c C-r" #'go-remove-unused-imports go-mode-map nil)
      (bind-key "M-." #'godef-jump go-mode-map nil)
      (bind-key "M-," #'pop-tag-mark go-mode-map nil)
      (bind-key "C-c C-i" #'go-import-add go-mode-map nil))

    (add-hook 'before-save-hook 'gofmt-before-save)
    (leaf go-eldoc
      :ensure t
      :config
      (add-hook 'go-mode-hook 'go-eldoc-setup))))
