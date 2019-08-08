(use-package ivy-rich
  :bind (
         ("C-x b" . ivy-switch-buffer)
         ("C-;" . ivy-switch-buffer)
         )
  :config
  (ivy-rich-mode 1)
  (require 'ivy-hydra)
  (setq ivy-use-virtual-buffers t)
  )

(use-package swiper
  :bind (("C-s" . swiper-isearch)
         )
  :config
  (ivy-rich-mode 1)
  )

(use-package counsel
  :bind* (
         ("M-x" . counsel-M-x)
         ("M-y" . counsel-yank-pop)
         ("C-M-z" . counsel-fzf)
         ("C-M-r" . counsel-recentf)
         ("C-x C-b" . counsel-ibuffer)
         ("C-M-f" . counsel-rgrubyb)
         ("C-c i" . counsel-imenu)
         )
  :config
  (counsel-mode 1)
  )
