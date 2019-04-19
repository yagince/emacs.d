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
  (setq rustic-rls-pkg 'eglot)
  :mode ("\\.rs$" . rustic-mode)
  :config
  (bind-keys :map rustic-mode-map
             ("C-c i" . swiper)
             )
  (use-package quickrun
    :defer t
    :ensure t)
  ;; (use-package lsp-mode
  ;;   :ensure t)
  )
