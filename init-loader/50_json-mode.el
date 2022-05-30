;; ;; (use-package json-mode
;; ;;   :mode (
;; ;;          ("\\.json$" . json-mode)
;; ;;          )
;; ;;   :init
;; ;;   (add-hook 'json-mode-hook
;; ;;             (lambda ()
;; ;;               (make-local-variable 'js-indent-level)
;; ;;               (setq js-indent-level 2)))
;; ;;   )
;; (leaf json-mode
;;   :ensure t
;;   :mode ("\\.json$")
;;   :config
;;   (add-hook 'json-mode-hook
;;             (lambda nil
;;               (make-local-variable 'js-indent-level)
;;               (setq js-indent-level 2))))

