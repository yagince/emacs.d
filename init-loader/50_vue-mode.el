;; (use-package vue-mode
;;   :mode (("\\.vue\\'" . vue-mode))
;;   :config
;;   (setq mmm-submode-decoration-level 0)
;;   (setq indent-tabs-mode nil
;;         js-indent-level 2
;;         typescript-indent-level 2)
;;   (add-hook 'vue-mode-hook #'add-node-modules-path)
;;   (add-hook 'vue-mode-hook 'yas-minor-mode)
;;   (add-hook 'vue-mode-hook 'flycheck-mode)
;;   )

(leaf vue-mode
  :ensure t
  :mode ("\\.vue\\'")
  :config
  (with-eval-after-load 'vue-mode
    (setq mmm-submode-decoration-level 0)
    (setq indent-tabs-mode nil
          js-indent-level 2
          typescript-indent-level 2)
    (add-hook 'vue-mode-hook #'add-node-modules-path)
p    (add-hook 'vue-mode-hook 'yas-minor-mode)
    (add-hook 'vue-mode-hook 'flycheck-mode)))
