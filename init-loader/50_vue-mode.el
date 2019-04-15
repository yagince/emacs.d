(use-package vue-mode
  :mode (("\\.vue\\'" . vue-mode))
  :config
  (setq indent-tabs-mode nil
        js-indent-level 2)
  (add-hook 'vue-mode-hook #'add-node-modules-path)
  (add-hook 'vue-mode-hook 'yas-minor-mode)
  (add-hook 'vue-mode-hook 'flycheck-mode)
  (flycheck-add-mode 'javascript-eslint 'vue-mode)
  (flycheck-add-mode 'javascript-eslint 'vue-html-mode)
  (flycheck-add-mode 'javascript-eslint 'css-mode)
  )
