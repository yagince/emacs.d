(require 'company)

;; C-n, C-pで補完候補を次/前の候補を選択
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)

;; C-sで絞り込む
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)

;; TABで候補を設定
(define-key company-active-map (kbd "M-/") 'company-complete-selection)

;; ;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
;; (define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete)
;; (global-set-key (kbd "M-/") 'company-complete)
