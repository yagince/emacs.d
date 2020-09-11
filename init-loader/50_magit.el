;; Magit
;; (use-package magit
;;   :bind (
;;          ("C-x m" . magit-status)
;;          )
;;   :config
;;   (setq-default magit-auto-revert-mode nil)
;;   (setq vc-handled-backends '())
;;   (eval-after-load "vc" '(remove-hook 'find-file-hooks 'vc-find-file-hook))
;;   (custom-set-faces
;;    '(magit-diff-added ((t (:background "black" :foreground "green"))))
;;    '(magit-diff-added-highlight ((t (:background "white" :foreground "green"))))
;;    '(magit-diff-removed ((t (:background "black" :foreground "blue"))))
;;    '(magit-diff-removed-hightlight ((t (:background "white" :foreground "blue"))))
;;    '(magit-hash ((t (:foreground "red"))))
;;    )
;;   )
(leaf magit
  :ensure t
  :bind (("C-x m" . magit-status))
  :config
  (with-eval-after-load 'magit
    (setq-default magit-auto-revert-mode nil)
    (setq vc-handled-backends 'nil)
    (eval-after-load "vc"
      '(remove-hook 'find-file-hooks 'vc-find-file-hook))

    (custom-set-faces
     '(magit-diff-added
       ((t
         (:background "black" :foreground "green"))))
     '(magit-diff-added-highlight
       ((t
         (:background "white" :foreground "green"))))
     '(magit-diff-removed
       ((t
         (:background "black" :foreground "blue"))))
     '(magit-diff-removed-hightlight
       ((t
         (:background "white" :foreground "blue"))))
     '(magit-hash
       ((t
         (:foreground "red")))))))
