(add-hook 'rust-mode-hook #'flycheck-mode)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
