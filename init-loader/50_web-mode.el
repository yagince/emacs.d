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
  (leaf prettier
    :ensure t
    :hook
    (
     (web-mode-hook . prettier-mode)
     )
    )
  )

;; (use-package web-mode
;;   :mode (
;;          ("\\.phtml$"     . web-mode)
;;          ("\\.tpl\\.php$" . web-mode)
;;          ("\\.jsp$"       . web-mode)
;;          ("\\.as[cp]x$"   . web-mode)
;;          ("\\.erb$"       . web-mode)
;;          ("\\.html?$"     . web-mode)
;;          ("\\.css?$"      . web-mode)
;;          ("\\.jsx$"       . web-mode)
;;          ("\\.js$"        . web-mode)
;;          ("\\.tsx$"       . web-mode)
;;          ("\\.ts$"        . web-mode)
;;          )
;;   :init
;;   (add-hook 'web-mode-hook
;;             '(lambda ()
;;                (company-mode t)
;;                (dumb-jump-mode t)
;;                (yas-minor-mode t)
;;                ))

;;   :config
;;   (setq auto-save-default nil)
;;   (setq web-mode-markup-indent-offset  2)
;;   (setq web-mode-css-indent-offset     2)
;;   (setq web-mode-code-indent-offset    2)
;;   (setq indent-tabs-mode               nil)
;;   (setq web-mode-enable-auto-pairing t)
;;   (setq web-mode-enable-auto-closing t)
;;   )

;; (use-package typescript-mode
;;   :mode (
;;          ("\\.tsx$" . typescript-mode)
;;          ("\\.ts$"  . typescript-mode)
;;          )
;;   :init
;;   (add-hook 'typescript-mode-hook
;;             '(lambda ()
;;                (company-mode t)
;;                (dumb-jump-mode t)
;;                (yas-minor-mode t)
;;                ))

;;   :config
;;   )
