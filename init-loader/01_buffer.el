(ido-mode 1)
(ido-everywhere 1)

(setq ido-enable-flex-matching t)

;; バッファ名変更
(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
  )
