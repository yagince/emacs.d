(ido-mode 1)
;; (require 'ido)

;; バッファ名変更
(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
  )
