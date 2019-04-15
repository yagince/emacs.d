;; (add-to-list 'exec-path (expand-file-name "~/.cargo/bin/"))
;; (add-hook 'rust-mode-hook 'flycheck-mode)
;; (add-hook 'rust-mode-hook 'yas-minor-mode)
;; (add-hook 'flycheck-mode-hook 'flycheck-rust-setup)
;; (add-hook 'rust-mode-hook 'dumb-jump-mode)
;; racer
;; (add-hook 'racer-mode-hook 'eldoc-mode)
;; (add-hook 'rust-mode-hook 'company-mode)
;; (add-hook 'rust-mode-hook 'racer-mode)



;; (require 'rust-mode)
;; (define-key rust-mode-map (kbd "M-/") #'company-indent-or-complete-common)
;; (setq company-tooltip-align-annotations t)
;; (add-hook 'racer-mode-hook (lambda ()
;;                              (company-mode)
;;                              ;;; この辺の設定はお好みで
;;                              (set (make-variable-buffer-local 'company-idle-delay) 1)
;;                              (set (make-variable-buffer-local 'company-minimum-prefix-length) 0)))

(use-package rustic
  :ensure t
  :defer t
  :init
  (yas-reload-all)
  (add-hook 'rustic-mode-hook
            '(lambda ()
               (company-mode t)
               (dumb-jump-mode t)
               (yas-minor-mode t)
               ))
  (setq rustic-rls-pkg 'eglot)
  :mode ("\\.rs$" . rustic-mode)
  :config
  (use-package quickrun
    :defer t
    :ensure t)
  ;; (use-package lsp-mode
  ;;   :ensure t)
  )

;; (use-package rustic
;;   :ensure t
;;   :defer t
;;   :init
;;   (add-hook 'rustic-mode-hook
;;             '(lambda ()
;;                (company-mode t)
;;                (dumb-jump-mode t)
;;                (yas-minor-mode t)
;;                (racer-mode t)
;;                (flymake-mode nil)
;;                (flycheck-mode t)
;;                ))
;;   (add-hook 'flycheck-mode-hook 'flycheck-rust-setup)
;;   :mode ("\\.rs$" . rustic-mode)
;;   :commands (rustic-mode)
;;   :config
;;   (use-package quickrun
;;     :defer t
;;     :ensure t)
;;   (use-package racer
;;     :defer t
;;     :ensure t)
;;   (use-package lsp-mode
;;     :ensure t)
;;   )

;; (setq rustic-rls-pkg 'eglot)
;; (setq rustic-lsp-server 'rust-analyzer)
