(use-package rustic
  :ensure t
  :defer t
  :init
  (yas-reload-all)
  (add-hook 'rustic-mode-hook
            '(lambda ()
               (company-mode t)
               (dumb-jump-mode t)
               (yas-minor-mode t)
               ))
  ;; (setq rustic-rls-pkg 'eglot)
  :mode ("\\.rs$" . rustic-mode)
  :config
  (bind-keys :map rustic-mode-map
             ("C-M-n" . rustic-end-of-defun)
             ("C-M-p" . rustic-beginning-of-defun)
             )
  ;; (setq rustic-format-on-save nil)
  ;; (setq rustic-lsp-format t)
  ;; (setq rustic-format-trigger 'on-save)
  (setq rustic-format-trigger nil)
  ;; (defun my-rustic-before-save-hook ()
  ;;   "rustic-format-buffer on before save"
  ;;   (message "===>> RUST-MODE_BEFORE-SAVE-HOOK: ＼(^o^)／")
  ;;   (when (derived-mode-p 'rustic-mode)
  ;;     (message "!!!! Before save HOOOOOOOOOOOOOOOOOK!!!")
  ;;     (rustic-format-buffer)
  ;;     )
  ;;   )
  ;; (add-hook 'before-save-hook
  ;;           'my-rustic-before-save-hook
  ;;           )
  (use-package quickrun
    :defer t
    :ensure t)
  ;; (use-package lsp-mode
  ;;   :ensure t)
  )
