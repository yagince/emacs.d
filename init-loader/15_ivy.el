(use-package ivy-rich
  :bind (("C-x b" . ivy-switch-buffer)
         )
  :config
  (ivy-rich-mode 1)
  )

(use-package swiper
  :bind (("C-s" . swiper-isearch)
         )
  :config
  (ivy-rich-mode 1)
  )

