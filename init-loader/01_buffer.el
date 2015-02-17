;; バッファきりかえ
;; (iswitchb-mode 1)
;; (setq read-buffer-function 'iswitchb-read-buffer)
;; (setq iswitchb-regex nil)
;; (setq iswitch-prompt-newbuffer nil)
(ido-mode 1)
(require 'ido)

;; バッファ名変更
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
