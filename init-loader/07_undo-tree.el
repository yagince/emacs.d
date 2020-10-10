;; undo-tree

;; (use-package undo-tree
;;   :bind (("C-S-/" . undo-tree-redo)
;;          )
;;   :init
;;   (global-undo-tree-mode t)
;;   )
(leaf undo-tree
  :ensure t
  :bind (
         ("C-M-/" . undo-tree-redo)
         ("C-/" . undo-tree-undo)
         )
  :config
  (global-undo-tree-mode t))
