(leaf magit
  :ensure t
  :bind (("C-x m" . magit-status))
  :config
  (with-eval-after-load 'magit
    (setq-default magit-auto-revert-mode nil)
    (setq vc-handled-backends 'nil)
    (eval-after-load "vc"
      '(remove-hook 'find-file-hooks 'vc-find-file-hook))
    ))
