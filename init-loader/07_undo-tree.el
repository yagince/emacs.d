;; undo-tree
;; (require 'undo-tree)
;; (global-undo-tree-mode t)
;; (global-set-key (kbd "C-S-/") 'undo-tree-redo)

(use-package undo-tree
  :bind (("C-S-/" . undo-tree-redo)
         )
  :init
  (global-undo-tree-mode t)
  )
