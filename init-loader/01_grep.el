;; rg
;; (use-package rg
;;   :init
;;   (rg-enable-default-bindings (kbd "M-s"))
;;   )
(leaf rg
  :ensure t
  :init
  (rg-enable-default-bindings
   (kbd "M-s"))
  :require t)

(leaf wgrep
  :ensure t
  :require t)
