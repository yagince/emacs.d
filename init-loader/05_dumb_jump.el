;; (use-package dumb-jump
;;   :defer t
;;   :bind (
;;          ("C-M-g" . dumb-jump-go)
;;          ("C-M-b" . dumb-jump-back)
;;          ("C-M-q" . dumb-jump-quick-look)
;;          )
;;   :config
;;   (setq dumb-jump-selector 'ivy)
;;   (bind-keys :map dumb-jump-mode-map
;;              ("C-M-p" . nil)
;;              )
;;   )
(leaf dumb-jump
  :ensure t
  :bind (("C-M-g" . dumb-jump-go)
         ("C-M-b" . dumb-jump-back)
         ("C-M-q" . dumb-jump-quick-look))
  :config
  (with-eval-after-load 'dumb-jump
    (setq dumb-jump-selector 'ivy)
    (bind-keys :map dumb-jump-mode-map
               ("C-M-p" . nil))))

(leaf smart-jump
  :ensure t
  :config
  (smart-jump-setup-default-registers))
