(use-package protobuf-mode
  :defer t
  :mode (("\\.proto\\'" . protobuf-mode))
  :config
  (add-hook 'protobuf-mode-hook
            '(lambda ()
               (company-mode t)
               (dumb-jump-mode t)
               (yas-minor-mode t)
               (setq tab-width 2)
               ))
  )
