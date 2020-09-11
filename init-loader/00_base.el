;; ツールバーを非表示
(tool-bar-mode -1)
;; メニューバーを非表示
(menu-bar-mode -1)

(prefer-coding-system 'utf-8)

(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

(setq backup-inhibited t)
(setq make-backup-files nil)
(setq create-lockfiles nil)
(setq auto-save-default nil)
(setq delete-auto-save-files t)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

;; 現在行をハイライト
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "dark slate gray"))
    (((class color)
      (background light))
     (:background "#AAAAAA"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
;; (setq hl-line-face 'underline) ; 下線
(global-hl-line-mode t)
;; 対応する括弧をハイライト
(show-paren-mode t)
;; 括弧のハイライトの設定。
(setq show-paren-style 'mixed)
;; 選択範囲をハイライト
(setq transient-mark-mode t)

(setq backup-directory-alist
  (cons (cons ".*" (expand-file-name "~/.emacs.d/backup"))
        backup-directory-alist))
(setq auto-save-file-name-transforms
  `((".*", (expand-file-name "~/.emacs.d/backup/") t)))

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; スクロールは１行ごとに
;; (setq scroll-step 1)
;;(scroll-bar-mode -1)
(setq scroll-conservatively 1)
(setq scroll-margin 3)

;; disabled auto-save
(setq auto-save-mode nil)
(setq buffer-auto-save-file-name nil)

;; M-x display-splash-screen で表示。
(setq inhibit-startup-message t)

;; default text mode
(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; 自動インデント無効
;; (electric-indent-mode -1)
(add-hook 'text-mode-hook '(lambda ()
                             (electric-indent-local-mode -1)))
(add-hook 'lisp-mode-hook '(lambda ()
                             (electric-indent-local-mode -1)))

;; 自動改行をoffにする
(setq text-mode-hook 'turn-off-auto-fill)

;; 列数を表示する
(column-number-mode t)

;; "yes or no" の選択を "y or n" にする
(fset 'yes-or-no-p 'y-or-n-p)

;; ;; 英語
;; (set-face-attribute 'default nil
;;                     :family "Menlo" ;; font
;;                     )    ;; font size

;; ;; 日本語
;; (set-fontset-font
;;  nil 'japanese-jisx0208
;;  (font-spec :family "Hiragino Kaku Gothic ProN")) ;; font

;; ;; 半角と全角の比を1:2にしたければ
;; ;; (setq face-font-rescale-alist
;; ;;       '((".*Hiragino_Kaku_Gothic_ProN.*" . 1.2)));; Mac用フォント設定
;; (add-to-list 'face-font-rescale-alist
;;              '(".*Hiragino Kaku Gothic ProN.*" . 1.2))

;; font
;; (set-default-font "Noto Sans Mono CJK JP-11")
(set-frame-font "Migu 2M-15")
;; (set-default-font "Ricty Diminished-11")
;; (set-default-font "MigMix 1M-11")

;; (set-default-font "Fira Code-11")
;; (set-default-font "Myrica M-11")
;; あいうえおあいうえおあいうえお
;; aaiiuueeooaaiiuueeooaaiiuueeoo

;; 警告音もフラッシュも全て無効(警告音が完全に鳴らなくなるので注意)
(setq ring-bell-function 'ignore)

;; 閉じる時に確認
(setq confirm-kill-emacs 'y-or-n-p)

(leaf all-the-icons
  :ensure t
  :custom ((all-the-icons-scale-factor . 1.0))
  :require t)

;; (use-package doom-modeline
;;   :commands (doom-modeline-def-modeline)
;;   :custom
;;   (doom-modeline-buffer-file-name-style 'truncate-with-project)
;;   (doom-modeline-icon t)
;;   (doom-modeline-major-mode-icon nil)
;;   (doom-modeline-minor-modes nil)
;;   :hook
;;   (after-init . doom-modeline-mode)
;;   :config
;;   )

(leaf doom-modeline
  :ensure t
  :commands doom-modeline-def-modeline
  :hook (after-init-hook)
  :custom ((doom-modeline-buffer-file-name-style quote truncate-with-project)
           (doom-modeline-icon . t)
           (doom-modeline-major-mode-icon)
           (doom-modeline-minor-modes)))
;; tramp
(setq tramp-default-method "sshx")
