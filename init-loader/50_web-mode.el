(leaf nvm
  :ensure t
  :config
  (nvm-use "16.13.0")
  )

(leaf add-node-modules-path
  :ensure t
  ;; :after nvm
  )

(leaf prettier
  :ensure t
  ;; :after nvm add-node-modules-path
  )

(leaf web-mode
  :ensure t
  :after nvm add-node-modules-path prettier
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
  :hook (
         (web-mode-hook . add-node-modules-path)
         (web-mode-hook . prettier-mode)
         (web-mode-hook . flycheck-mode)
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
  )

;; (leaf typescript-mode
;;   :ensure t
;;   :after nvm add-node-modules-path prettier
;;   ;; :mode (
;;   ;;        "\\.tsx$"
;;   ;;        "\\.ts$"
;;   ;;        )
;;   :hook (
;;          (typescript-mode-hook . company-mode)
;;          (typescript-mode-hook . dumb-jump-mode)
;;          (typescript-mode-hook . yas-minor-mode)
;;          (typescript-mode-hook . flycheck-mode)
;;          (typescript-mode-hook . prettier-mode)
;;          )
;;   :custom
;;   (
;;    (typescript-indent-level . 2)
;;    )
;;   ;; :config
;;   )

