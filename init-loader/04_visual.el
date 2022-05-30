;; ;; タブ, 全角スペース, 行末空白表示
;; (defface my-face-b-1 '((t (:background "NavajoWhite4"))) nil) ; 全角スペース
;; (defface my-face-b-2 '((t (:background "gray10"))) nil) ; タブ
;; (defface my-face-u-1 '((t (:background "SteelBlue" :underline t))) nil) ; 行末空白
;; (defvar my-face-b-1 'my-face-b-1)
;; (defvar my-face-b-2 'my-face-b-2)
;; (defvar my-face-u-1 'my-face-u-1)

;; (defadvice font-lock-mode (before my-font-lock-mode ())
;;  (font-lock-add-keywords
;;  major-mode
;;  '(("\t" 0 my-face-b-2 append)
;;  ("　" 0 my-face-b-1 append)
;;  ("[ \t]+$" 0 my-face-u-1 append)
;;  )))
;; (ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
;; (ad-activate 'font-lock-mode)

;; ;; デフォルトのインデント
;; (setq-default indent-line-function 'tab-to-tab-stop)
;; (setq-default tab-width 2)
;; (setq-default tab-stop-list '(2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60
;;                                 62 64 66 68 70 72 74 76 78 80 82 84 86 88 90 92 94 96 98 100 102 104 106 108 110 112 114 116 118 120))
;; (setq-default indent-tabs-mode nil)

;; ;; theme
;; ;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;; ;; (load-theme 'pastels-on-dark t)
;; ;; (load-theme 'manoj-dark t)
;; (leaf cyberpunk-theme
;;   :ensure t
;;   :config
;;   (load-theme 'cyberpunk t)
;;   )

;; (when (equal system-type 'darwin)
;;   (setq initial-frame-alist
;;         (append (list '(width . 170)
;;                       '(height . 60)
;;                       '(top . 10)
;;                       '(left . 10)
;;                       '(alpha . 85))
;;                 initial-frame-alist)))

;; (when (equal system-type 'gnu/linux)
;;   (setq initial-frame-alist
;;         (append (list '(width . 310)
;;                       '(height . 67)
;;                       '(top . 10)
;;                       '(left . 10)
;;                       '(alpha . 85))
;;                 initial-frame-alist)))

;; (setq default-frame-alist initial-frame-alist)
