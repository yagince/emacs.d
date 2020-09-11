;; (use-package csharp-mode
;;   :defer t
;;   :mode (
;;          ("\\.cs$'" . csharp-mode)
;;          ("\\.csx$" . csharp-mode)
;;          )
;;   :config
;;   )
(leaf csharp-mode
  :ensure t
  :mode ("\\.cs$'" "\\.csx$"))
