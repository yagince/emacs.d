(use-package open-junk-file
  :init
  (setq open-junk-file-format "~/program/junk/%Y/%m/%Y-%m-%d-%H%M%S.")
  :bind ("C-x j" . open-junk-file)
  )
