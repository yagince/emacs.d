;; (use-package protobuf-mode
;;   :defer t
;;   :mode (("\\.proto\\'" . protobuf-mode))
;;   :config
;;   (add-hook 'protobuf-mode-hook
;;             '(lambda ()
;;                (company-mode t)
;;                (dumb-jump-mode t)
;;                (yas-minor-mode t)
;;                (setq tab-width 2)
;;                ))
;;   )

(leaf protobuf-mode
  :ensure t
  :mode ("\\.proto\\'")
  :config
  (with-eval-after-load 'protobuf-mode
    (add-hook 'protobuf-mode-hook
              '(lambda nil
                 (company-mode t)
                 (dumb-jump-mode t)
                 (yas-minor-mode t)
                 (setq tab-width 2)))))

