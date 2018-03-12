(global-set-key "\C-h" 'backward-delete-char)
(define-key global-map [?¥] [?\\])
(define-key global-map (kbd "C-z") nil)

;; (require 'selected)
;; ;;; 他のパッケージよりもselectedの設定を優先させる
;; (setq selected-minor-mode-override t)
;; (selected-global-mode 1)
;; (define-key selected-keymap (kbd "q") #'selected-off)
;; (define-key selected-keymap (kbd "u") #'upcase-region)
;; (define-key selected-keymap (kbd "d") #'downcase-region)
;; (define-key selected-keymap (kbd "w") #'count-words-region)
;; (define-key selected-keymap (kbd "m") #'apply-macro-to-region-lines)

;; goto-chg
(require 'goto-chg)
(global-set-key (kbd "<f8>") 'goto-last-change)
(global-set-key (kbd "M-<f8>") 'goto-last-change-reverse)
