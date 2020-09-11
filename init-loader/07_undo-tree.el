;; undo-tree

;; (use-package undo-tree
;;   :bind (("C-S-/" . undo-tree-redo)
;;          )
;;   :init
;;   (global-undo-tree-mode t)
;;   )
(leaf undo-tree
  :ensure t
  :bind (("C-S-/" . undo-tree-redo))
  :config
  (global-undo-tree-mode t))
