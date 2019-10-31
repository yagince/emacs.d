(use-package neotree
  :init
  :config
  ;; 隠しファイルをデフォルトで表示
  (setq neo-show-hidden-files t)
  (setq neo-keymap-style 'concise)
  (setq neo-smart-open t)
  (setq neo-create-file-auto-open t)
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  )
