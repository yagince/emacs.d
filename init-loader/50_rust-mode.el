(add-hook 'rust-mode-hook 'flycheck-mode)
(add-hook 'rust-mode-hook 'yas-minor-mode)
(add-hook 'flycheck-mode-hook 'flycheck-rust-setup)
(add-hook 'rust-mode-hook 'dumb-jump-mode)
;; racer
(add-to-list 'exec-path (expand-file-name "~/.cargo/bin/"))
(add-hook 'racer-mode-hook 'eldoc-mode)
(add-hook 'rust-mode-hook 'company-mode)
(add-hook 'rust-mode-hook 'racer-mode)

(require 'rust-mode)
(define-key rust-mode-map (kbd "M-/") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)
(add-hook 'racer-mode-hook (lambda ()
                             (company-mode)
                             ;;; この辺の設定はお好みで
                             (set (make-variable-buffer-local 'company-idle-delay) 0.1)
                             (set (make-variable-buffer-local 'company-minimum-prefix-length) 0)))


