(use-package web-mode
  :mode (
         ("\\.phtml$"     . web-mode)
         ("\\.tpl\\.php$" . web-mode)
         ("\\.jsp$"       . web-mode)
         ("\\.as[cp]x$"   . web-mode)
         ("\\.erb$"       . web-mode)
         ("\\.html?$"     . web-mode)
         ("\\.js?$"       . web-mode)
         ("\\.css?$"      . web-mode)
         ("\\.jsx$"       . web-mode)
         )
  :config
  (setq web-mode-markup-indent-offset  2)
  (setq web-mode-css-indent-offset     2)
  (setq web-mode-code-indent-offset    2)
  (setq indent-tabs-mode               nil)
  )
