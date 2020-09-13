(leaf ivy
  :ensure t
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
      (counsel-mode 1)))

  (leaf prescient
    :doc "Better sorting and filtering(補完候補の使用履歴が新しいものを上に持ってきてくれる)"
    :req "emacs-25.1"
    :tag "extensions" "emacs>=25.1"
    :url "https://github.com/raxod502/prescient.el"
    :emacs>= 25.1
    :ensure t
    :commands (prescient-persist-mode)
    :custom `((prescient-aggressive-file-save . t)
              (prescient-save-file . ,(locate-user-emacs-file "prescient")))
    :global-minor-mode prescient-persist-mode)

  (leaf ivy-prescient
    :doc "prescient.el + Ivy"
    :req "emacs-25.1" "prescient-4.0" "ivy-0.11.0"
    :tag "extensions" "emacs>=25.1"
    :url "https://github.com/raxod502/prescient.el"
    :emacs>= 25.1
    :ensure t
    :after prescient ivy
    :custom ((ivy-prescient-retain-classic-highlighting . t))
    :global-minor-mode t))
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
