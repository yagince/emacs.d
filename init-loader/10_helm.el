(use-package helm
  :bind (("C-;" . helm-mini)
         ("M-x" . helm-M-x)
         ("M-y" . helm-show-kill-ring)
         ("C-c i" . helm-imenu)
         ("C-x C-b" . helm-buffers-list)
         )
  :config
  (define-key helm-map (kbd "C-h") 'delete-backward-char)
  )
