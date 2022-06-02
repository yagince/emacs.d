;; ;; markdown-mode
;; ;; (use-package markdown-mode
;; ;;   :mode (
;; ;;          ("\\.markdown\\'" . markdown-mode)
;; ;;          ("\\.md\\'" . markdown-mode)
;; ;;          ("README\\.md\\'" . gfm-mode)
;; ;;          )
;; ;;   :config
;; ;;   (add-hook 'markdown-mode-hook '(lambda ()
;; ;;                                    (electric-indent-local-mode -1)))
;; ;;   (setq markdown-preview-stylesheets 
;; ;;         (list "https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/3.0.1/github-markdown.min.css"))
;; ;;   )

;; (leaf markdown-mode
;;   :ensure t
;;   :mode ("\\.markdown\\'" "\\.md\\'"
;;          ("README\\.md\\'" . gfm-mode))
;;   :config
;;   (with-eval-after-load 'markdown-mode
;;     (add-hook 'markdown-mode-hook
;;               '(lambda nil
;;                  (electric-indent-local-mode -1)))
;;     (setq markdown-preview-stylesheets (list "https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/3.0.1/github-markdown.min.css"))))

