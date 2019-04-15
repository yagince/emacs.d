;; scala-mode
(use-package ensime
  :defer t
  :mode (("\\.scala\\'" . scala-mode)
         ("\\.sbt\\'" . scala-mode)
         )
  :init
  (setenv "PATH" (concat "/usr/local/bin/sbt:" (getenv "PATH")))
  (setenv "PATH" (concat "/usr/local/bin/scala:" (getenv "PATH")))
  (add-to-list 'exec-path "/usr/local/bin")
  :config
  (bind-keys :map ensime-mode-map
             ("M-/" . ensime-import-type-at-point)
             )
  )
