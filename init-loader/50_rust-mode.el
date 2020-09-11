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
  :config
  (yas-reload-all)
  (add-hook 'rustic-mode-hook
            '(lambda nil
               (company-mode t)
               (dumb-jump-mode t)
               (yas-minor-mode t)))
  (with-eval-after-load 'rustic
    (progn
      (bind-key "C-M-n" #'rustic-end-of-defun rustic-mode-map nil)
      (bind-key "C-M-p" #'rustic-beginning-of-defun rustic-mode-map nil))

    (setq rustic-format-on-save nil)
    (setq rustic-lsp-format t)
    (setq rustic-format-trigger 'on-save)))
