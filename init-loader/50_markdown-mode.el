;; ;; markdown-mode
;; (autoload 'markdown-mode "markdown-mode"
;;    "Major mode for editing Markdown files" t)
;; ;; (add-to-list 'auto-mode-alist '("\\.text\\'" . gfm-mode))
;; (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
;; ;; (add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
;; ;; (add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

;; (add-hook 'markdown-mode-hook '(lambda ()
;;                                  (electric-indent-local-mode -1)))

(use-package markdown-mode
  :mode (
         ("\\.markdown\\'" . markdown-mode)
         ("\\.md\\'" . markdown-mode)
         )
  :config
  (add-hook 'markdown-mode-hook '(lambda ()
                                   (electric-indent-local-mode -1)))
  )
