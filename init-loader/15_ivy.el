(leaf ivy
  :config
  (leaf all-the-icons-ivy-rich :ensure t)
  (leaf ivy-rich
    :ensure t
    :bind (("C-x b" . ivy-switch-buffer)
           ("C-;" . ivy-switch-buffer))
    :config
    (with-eval-after-load 'ivy-rich
      (all-the-icons-ivy-rich-mode 1)
      (ivy-rich-mode 1)
      (setq ivy-use-virtual-buffers t)))

  (leaf ivy-hydra
    :ensure t
    )

  (leaf swiper
    :ensure t
    :bind (("C-s" . swiper-isearch))
    :config
    (with-eval-after-load 'swiper
      (ivy-rich-mode 1)))

  (leaf counsel
    :ensure t
    :bind (("M-x" . counsel-M-x)
           ("M-y" . counsel-yank-pop)
           ("C-M-z" . counsel-fzf)
           ("C-M-r" . counsel-recentf)
           ("C-x C-b" . counsel-ibuffer)
           ("C-M-f" . counsel-rgrubyb)
           ("C-c i" . counsel-imenu))
    :config
    (with-eval-after-load 'counsel
      (counsel-mode 1))))
;; (use-package ivy-rich
;;   :ensure t
;;   :bind (
;;          ("C-x b" . ivy-switch-buffer)
;;          ("C-;" . ivy-switch-buffer)
;;          )
;;   :config
;;   (ivy-rich-mode 1)
;;   (require 'ivy-hydra)
;;   (setq ivy-use-virtual-buffers t)
;;   )

;; (use-package swiper
;;   :ensure t
;;   :bind (("C-s" . swiper-isearch)
;;          )
;;   :config
;;   (ivy-rich-mode 1)
;;   )

;; (use-package counsel
;;   :ensure t
;;   :bind (
;;          ("M-x" . counsel-M-x)
;;          ("M-y" . counsel-yank-pop)
;;          ("C-M-z" . counsel-fzf)
;;          ("C-M-r" . counsel-recentf)
;;          ("C-x C-b" . counsel-ibuffer)
;;          ("C-M-f" . counsel-rgrubyb)
;;          ("C-c i" . counsel-imenu)
;;          )
;;   :config
;;   (counsel-mode 1)
;;   )
