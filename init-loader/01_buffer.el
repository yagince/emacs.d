(setq initial-major-mode 'org-mode)

(ido-mode 1)
(ido-everywhere 1)

(setq ido-enable-flex-matching t)

;; バッファ名変更
;; (use-package uniquify
;;   :config
;;   (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
;;   )
(leaf uniquify
  :require t
  :setq ((uniquify-buffer-name-style quote post-forward-angle-brackets)))
