(use-package expand-region
  :bind (
         ("C-," . er/expand-region)
         ("C-<" . er/contract-region) ;; リージョンを狭める
         )
  :init
  ;; transient-mark-modeが nilでは動作しませんので注意
  (transient-mark-mode t)
  )
