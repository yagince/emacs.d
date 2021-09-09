;; (use-package rustic
;;   :ensure t
;;   :defer t
;;   :init
;;   (yas-reload-all)
;;   (add-hook 'rustic-mode-hook
;;             '(lambda ()
;;                (company-mode t)
;;                (dumb-jump-mode t)
;;                (yas-minor-mode t)
;;                ))
;;   :mode ("\\.rs$" . rustic-mode)
;;   :config
;;   (bind-keys :map rustic-mode-map
;;              ("C-M-n" . rustic-end-of-defun)
;;              ("C-M-p" . rustic-beginning-of-defun)
;;              )
;;   (setq rustic-format-on-save nil)
;;   (setq rustic-lsp-format t)
;;   (setq rustic-format-trigger 'on-save)
;;   )

(leaf rustic
  :ensure t
  :mode ("\\.rs$")
  :custom (;; debug
           (lsp-print-io          . nil)
           (lsp-trace             . nil)
           (lsp-print-performance . nil)
           ;; general
           ;; (lsp-auto-guess-root      . t)
           ;; (lsp-document-sync-method . 'incremental) ;; always send incremental document
           (lsp-response-timeout     . 5)
           (lsp-prefer-flymake       . 'flymake)
           ;; (lsp-enable-completion-at-point . nil)
           (rustic-format-on-save    . t)
           (rustic-lsp-format        . t)
           (rustic-format-trigger    . nil)
           ;; (rustic-rls-pkg           . 'eglot)
           )
  :config
  (yas-reload-all)
  (add-hook 'rustic-mode-hook
            '(lambda nil
               (company-mode t)
               (dumb-jump-mode t)
               (yas-minor-mode t)))
  (add-hook 'eglot--managed-mode-hook (lambda () (flymake-mode -1)))
  (with-eval-after-load 'rustic
    (progn
      (bind-key "C-M-n" #'rustic-end-of-defun rustic-mode-map nil)
      (bind-key "C-M-p" #'rustic-beginning-of-defun rustic-mode-map nil))

    ;; (setq rustic-rls-pkg 'eglot)
    ;; (setq rustic-format-on-save nil)
    ;; (setq rustic-lsp-format nil)
    ;; (setq rustic-format-trigger nil)
    )
  )
