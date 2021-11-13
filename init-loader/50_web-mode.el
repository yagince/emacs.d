(leaf web-mode
  :ensure t
  :mode ("\\.phtml$"
         "\\.tpl\\.php$"
         "\\.jsp$"
         "\\.as[cp]x$"
         "\\.erb$"
         "\\.html?$"
         "\\.css?$"
         "\\.jsx$"
         "\\.js$"
         "\\.tsx$"
         "\\.ts$"
         )
  :config
  (add-hook 'web-mode-hook
            '(lambda nil
               (company-mode t)
               (dumb-jump-mode t)
               (yas-minor-mode t)))

  (with-eval-after-load 'web-mode
    (setq auto-save-default nil)
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-css-indent-offset 2)
    (setq web-mode-code-indent-offset 2)
    (setq indent-tabs-mode nil)
    (setq web-mode-enable-auto-pairing t)
    (setq web-mode-enable-auto-closing t)
    )
  (leaf nvm
    :ensure t
    :config
    (nvm-use "16.13.0")
    )
  (leaf add-node-modules-path
    :ensure t
    :after nvm
    :hook
    (
     (web-mode-hook . add-node-modules-path)
     )
    )
  (leaf prettier
    :ensure t
    :after nvm add-node-modules-path
    :hook
    (
     (web-mode-hook . prettier-mode)
     )
    )
  ;; (leaf nvm
  ;;   :ensure t
  ;;   :config
  ;;   (
  ;;    nvm-use "v14.17.1"
  ;;    )
  ;;  )
  ;; (leaf flymake-eslint
  ;;   :ensure t
  ;;   :hook
  ;;   (
  ;;    (web-mode-hook . flymake-eslint-enable)
  ;;    )
  ;;   )
  )
