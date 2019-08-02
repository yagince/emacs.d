(use-package js2-mode
  :mode (
         ("\\.js$" . js2-mode)
         ("\\.mjs$" . js2-mode)
         )
  :config
  (add-hook 'js2-mode-hook
            '(lambda ()
               (setq js2-basic-offset 2
                     tab-width        2
                     indent-tabs-mode nil
                     js2-cleanup-whitespace nil))
            )
  )
