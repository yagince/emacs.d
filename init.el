;; Package initialization
(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")
                       ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
  (package-initialize))

;; use-package setup (built-in for Emacs 29+)
(require 'use-package)
(setq use-package-always-ensure t)  ; Always ensure packages are installed

;; Keep leaf for now during migration
(unless (package-installed-p 'leaf)
  (package-refresh-contents)
  (package-install 'leaf))


(leaf leaf-keywords
  :ensure t
  :init
  ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
  (leaf hydra :ensure t)
  (leaf el-get :ensure t)
  (leaf blackout :ensure t)

  :config
  ;; initialize leaf-keywords.el
  (leaf-keywords-init))

;; custom設定がinit.elに書き込まれないようにする
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(setq gc-cons-threshold (* 128 1024 1024))
(setq ring-bell-function 'ignore)

;; Now you can use leaf!
(leaf leaf-convert :ensure t)
(leaf leaf-tree
  :ensure t
  :custom ((imenu-list-size . 30)
           (imenu-list-position . 'left)))

;; Migrated to use-package
(use-package macrostep
  :ensure t
  :bind ("C-c e" . macrostep-expand))

;; Migrated to use-package
(use-package exec-path-from-shell
  :ensure t
  :demand t  ; :require t の代替
  :custom
  (exec-path-from-shell-variables '("RUST_SRC_PATH"
                                     "GOPATH"
                                     "PATH"))
  :config
  (exec-path-from-shell-initialize))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 00_base.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ツールバーを非表示
(tool-bar-mode -1)
;; メニューバーを非表示
(menu-bar-mode -1)
;; C-x M-x などで英語モードに切り替える
;;(mac-auto-ascii-mode 1)

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
;; (set-frame-font "Migu 2M-17")
;; (set-fontset-font t 'japanese-jisx0208 "Migu 2M-17")
;; (set-frame-font "Migu 2M-20")
;; (set-fontset-font t 'japanese-jisx0208 "Migu 2M-20")
(set-face-attribute 'default nil :height 170)
;; (set-frame-font "Ricty")
(set-frame-font "HackGen-16")

;; (set-fontset-font t 'japanese-jisx0208 "Ricty Diminished")
;; (set-frame-font "Noto Sans Mono CJK JP-11")
;; (add-to-list 'face-font-rescale-alist
;;              '(".*Ricty Diminished.*" . 1.1))

(when (eq system-type 'darwin) ; Mac OS X
  ;; 日本語フォントを明示的にHackGenに設定
  (set-fontset-font t 'japanese-jisx0208 "HackGen")
  (set-fontset-font t 'japanese-jisx0212 "HackGen")
  (set-fontset-font t 'japanese-jisx0213-1 "HackGen")
  (set-fontset-font t 'japanese-jisx0213-2 "HackGen")
  (set-fontset-font t 'katakana-jisx0201 "HackGen")

  ;; 絵文字フォントの設定
  (when (>= emacs-major-version 28)
    (set-fontset-font t 'emoji "Apple Color Emoji" nil 'prepend))

  ;; シンボルフォントの設定
  (set-fontset-font t 'symbol "Apple Color Emoji" nil 'append)

  ;; rescale設定
  (add-to-list 'face-font-rescale-alist
               '(".*Apple Color Emoji.*" . 0.5))

  ;; フォントキャッシュを無効化
  (setq inhibit-compacting-font-caches t)

  ;; すべての行に統一した高さを設定
  (setq-default default-text-properties
                '(line-height (1.3 . 1.3)))

  ;; 行間を広げて絵文字があっても行高さが変わらないようにする
  (setq-default line-spacing 3)
)

(when (eq system-type 'gnu/linux) ; linux
  (set-fontset-font nil '(#x1F000 . #x1FAFF) "Noto Color Emoji")
)

;; (set-fontset-font nil '(#x1F000 . #x1FAFF) "Apple Color Emoji")
;; (set-default-font "Ricty Diminished-11")
;; (set-default-font "MigMix 1M-11")

;; (set-default-font "Fira Code-11")
;; (set-default-font "Myrica M-11")

;;; ずれ確認用 半角40字、全角20字
;;; AIfUEaiueoAIUEOaiueoAIUEOaiueoAIUEOaiueo ASCII英字
;;; 0123456789012345678901234567890123456789 ASCII数字
;;; ｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵ JIS X 0201ｶﾅ
;;; あいうえおあいうえおあいうえおあいうえお JIS X 0208ひらがな
;;; アイウエオアイウエオアイウエオアイウエオ 同カタカナ
;;; ＡＢＣＤＥＡＢＣＤＥＡＢＣＤＥＡＢＣＤＥ 同英字
;;; 亜唖娃阿哀亜唖娃阿哀亜唖娃阿哀亜唖娃阿哀 同漢字
;;; 𠀋𡈽𡌛𡑮𡢽𠀋𡈽𡌛𡑮𡢽𠀋𡈽𡌛𡑮𡢽𠀋𡈽𡌛𡑮𡢽 JIS X 0213漢字
;;; 🀄🀅🀆🀇🀈🀄🀅🀆🀇🀈🀄🀅🀆🀇🀈🀄🀅🀆🀇🀈 絵文字
;;; あいうえおあいうえおあいうえおあいうえおあいうえおあいうえお
;;; aaiiuueeooaaiiuueeooaaiiuueeooaaiiuueeooaaiiuueeooaaiiuueeoo

;; 警告音もフラッシュも全て無効(警告音が完全に鳴らなくなるので注意)
(setq ring-bell-function 'ignore)

;; 閉じる時に確認
(setq confirm-kill-emacs 'y-or-n-p)

;; Migrated to use-package
(use-package all-the-icons
  :ensure t
  :demand t
  :custom
  (all-the-icons-scale-factor 1.0))

;; Migrated to use-package
(use-package doom-modeline
  :ensure t
  :commands doom-modeline-def-modeline
  :hook (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-buffer-file-name-style 'truncate-with-project)
  (doom-modeline-icon t)
  (doom-modeline-major-mode-icon nil)
  (doom-modeline-minor-modes nil))

;; tramp - Migrated to use-package
(use-package tramp
  :ensure t
  :custom
  (tramp-default-method "scp")
  (tramp-persistency-file-name "~/.emacs.d/tramp")
  (tramp-verbose 1)
  (tramp-use-ssh-controlmaster-options "")
  :config
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
  (add-to-list 'tramp-remote-path "/home/natsuki/.cargo/bin")
  (add-to-list 'tramp-remote-path "/home/natsuki/.nvm/versions/node/v24.2.0/bin")
  (add-to-list 'tramp-remote-path "/home/natsuki/.rbenv/shims"))

;; Migrated to use-package
(use-package autorevert
  :ensure t
  :init
  (global-auto-revert-mode 1))

;; Migrated to use-package
(use-package paren
  :ensure t
  :init
  (show-paren-mode 1))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 00_keybindings.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-unset-key (kbd "M-SPC"))
(global-set-key "\C-h" 'backward-delete-char)
(define-key global-map [?¥] [?\\])
(define-key global-map (kbd "C-z") nil)

;; Migrated to use-package
(use-package bind-key
  :ensure t)

;; Migrated to use-package
(use-package goto-chg
  :ensure t
  :bind (("<f8>" . goto-last-change)
         ("M-<f8>" . goto-last-change-reverse)))

(leaf mozc
  :ensure t
  :if (eq system-type 'gnu/linux)
  :bind* ("M-SPC" . toggle-input-method)
  :config
  (setq default-input-method "japanese-mozc"
        mozc-helper-program-name "mozc_emacs_helper"
        mozc-leim-title "Mozc"
        )
  :preface
  (defadvice toggle-input-method (around toggle-input-method-around activate)
    "Input method function in key-chord.el not to be nil."
    (let ((input-method-function-save input-method-function))
      ad-do-it
      (setq input-method-function input-method-function-save)))
  (defun mozc-insert-str (str)
    "If punctuation marks, immediately confirm."
    (mozc-handle-event 'enter)
    (toggle-input-method)
    (insert str)
    (toggle-input-method))
  (add-hook 'mozc-mode-hook
            (lambda ()
              (define-key mozc-mode-map "?" '(lambda () (interactive) (mozc-insert-str "？")))
              (define-key mozc-mode-map "," '(lambda () (interactive) (mozc-insert-str "、")))
              (define-key mozc-mode-map "." '(lambda () (interactive) (mozc-insert-str "。")))))
  :init
  ;; (leaf mozc-temp
  ;;   :ensure t
  ;;   :bind* ("C-M-n" . mozc-temp-convert))
  (leaf mozc-cursor-color
    :el-get iRi-E/mozc-el-extensions
    :require t
    :config
    (setq mozc-cursor-color-alist
          '((direct . "#BD93F9")
            (read-only . "#84A0C6")
            (hiragana . "#CC3333"))))
  (leaf mozc-cand-posframe
    :ensure t
    :require t
    :config
    (setq mozc-candidate-style 'posframe)
    :init
    (leaf posframe :ensure t)))


(leaf *user-mozc-tool
  :if (eq system-type 'gnu/linux)
  :init
  (defun my:select-mozc-tool ()
    "Narrow the only espy command in M-x."
    (interactive)
    (counsel-M-x "^my:mozc "))

  (defun my:mozc-config-dialog ()
    "Run the mozc-tool in the background."
    (interactive)
    (compile "/usr/lib/mozc/mozc_tool --mode=config_dialog")
    (delete-other-windows))

  (defun my:mozc-dictionary-tool ()
    "Run the mozc-tool in the background."
    (interactive)
    (compile "/usr/lib/mozc/mozc_tool --mode=dictionary_tool")
    (delete-other-windows))

  (defun my:mozc-word-regist ()
    "Run the mozc-tool in the background."
    (interactive)
    (compile "/usr/lib/mozc/mozc_tool --mode=word_register_dialog")
    (delete-other-windows))

  (defun my:mozc-hand-writing ()
    "Run the mozc-tool in the background."
    (interactive)
    (compile "/usr/lib/mozc/mozc_tool --mode=hand_writing")
    (delete-other-windows)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 01_buffer.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq initial-major-mode 'org-mode)

(ido-mode 1)
(ido-everywhere 1)

(setq ido-enable-flex-matching t)

;; Migrated to use-package
(use-package multiple-cursors
  :ensure t
  :demand t)

;; Migrated to use-package
(use-package anzu
  :ensure t
  :demand t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 01_grep.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Migrated to use-package
(use-package rg
  :ensure t
  :bind ("M-s" . rg))

;; Migrated to use-package
(use-package wgrep
  :ensure t
  :custom
  (wgrep-auto-save-buffer t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 02_cua.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 矩形モード
(cua-mode t)
(setq cua-enable-cua-keys nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 04_visual.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; タブ, 全角スペース, 行末空白表示 - Migrated to use-package
(use-package whitespace
  :ensure t
  :custom
  (whitespace-style '(face
                      trailing
                      tabs
                      spaces
                      space-mark
                      tab-mark))
  (whitespace-space-regexp "\\(\u3000+\\)")
  (whitespace-display-mappings '((space-mark ?\u3000 [?\u25a1])
                                 (tab-mark ?\t [?\u00BB ?\t])))
  ;; ;; 末尾スペースを自動削除
  ;; (whitespace-action '(auto-cleanup))

  :hook
  (prog-mode . whitespace-mode)

  :config
  ;; フェイス設定
  (set-face-attribute 'whitespace-space nil
                      :background 'unspecified
                      :foreground "gray30")
  (set-face-attribute 'whitespace-tab nil
                      :background 'unspecified
                      :foreground "gray30")
  (set-face-attribute 'whitespace-trailing nil
                      :background "red1"
                      :foreground 'unspecified)
  (global-whitespace-mode 1))

;; デフォルトのインデント
(setq-default indent-line-function 'tab-to-tab-stop)
(setq-default tab-width 2)
(setq-default tab-stop-list '(2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60
                                62 64 66 68 70 72 74 76 78 80 82 84 86 88 90 92 94 96 98 100 102 104 106 108 110 112 114 116 118 120))
(setq-default indent-tabs-mode nil)

;; theme
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;; (load-theme 'pastels-on-dark t)
;; (load-theme 'manoj-dark t)
;; (leaf cyberpunk-theme
;;   :ensure t
;;   :config
;;   (load-theme 'cyberpunk t)
;;   )
;; Migrated to use-package
(use-package modus-themes
  :ensure t
  :bind ("<f5>" . modus-themes-toggle)
  :init
  (load-theme 'modus-vivendi-deuteranopia :no-confirm))

;; (leaf timu-macos-theme
;;   :ensure t
;;   :config
;;   (load-theme 'timu-macos :no-confirm)
;;   )

(when (equal system-type 'darwin)
  (setq initial-frame-alist
        (append (list '(alpha . 80))
                initial-frame-alist)))

(when (equal system-type 'gnu/linux)
  (setq initial-frame-alist
        (append (list '(width . 310)
                      '(height . 67)
                      '(top . 10)
                      '(left . 10)
                      '(alpha . 80))
                initial-frame-alist)))
(setq default-frame-alist initial-frame-alist)
(set-frame-parameter nil 'fullscreen 'maximized)

;; Migrated to use-package
(use-package highlight-symbol
  :ensure t
  :hook ((prog-mode . highlight-symbol-mode)
         (prog-mode . highlight-symbol-nav-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 05_dumb_jump.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package dumb-jump
  :ensure t
  :bind (("C-M-g" . dumb-jump-go)
         ("C-M-b" . dumb-jump-back)
         ("C-M-q" . dumb-jump-quick-look))
  :config
  (setq dumb-jump-selector 'ivy)
  (bind-keys :map dumb-jump-mode-map
             ("C-M-p" . nil))
  :hook
  (xref-backend-functions . dumb-jump-xref-activate))

;; Migrated to use-package
(use-package smart-jump
  :ensure t
  :after ivy
  :bind
  ("M-." . smart-jump-go)
  :custom
  (dumb-jump-mode t)
  (dumb-jump-selector 'ivy) ;; 候補選択をivyに任せます
  (dumb-jump-use-visible-window nil)
  :config
  (smart-jump-setup-default-registers)
  ;; Ruby-modeでdumb-jumpを直接使用
  (smart-jump-register
   :modes 'ruby-mode
   :jump-fn 'dumb-jump-go
   :pop-fn 'dumb-jump-back
   :refs-fn 'dumb-jump-quick-look
   :should-jump t
   :heuristic 'point
   :async nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 05_linum.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (leaf linum
;;   :ensure t
;;   :require t
;;   :config
;;   (global-linum-mode t)
;;   (setq linum-format "%4d ")
;;   )

(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 05_neotree.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (leaf neotree
;;   :ensure t
;;   :bind (("C-x n" . neotree-show))
;;   :config
;;   (with-eval-after-load 'neotree
;;     ;; (setq neo-show-hidden-files t) ;; 隠しファイルをデフォルトで表示
;;     ;; (setq neo-keymap-style 'concise)
;;     ;; (setq neo-smart-open t)
;;     ;; (setq neo-create-file-auto-open t)
;;     ;; (setq neo-create-file-auto-open t)
;;     (setq neo-theme (if (display-graphic-p)
;;                         'icons 'arrow)))
;;   :custom
;;   (
;;    (neo-show-hidden-files . t) ;; 隠しファイルをデフォルトで表示
;;    ;; (neo-keymap-style . 'concise)
;;    (neo-smart-open . t)
;;    (neo-create-file-auto-open . t)
;;    (neo-create-file-auto-open . t)
;;    (projectile-switch-project-action . 'neotree-projectile-action)
;;    (neo-window-fixed-size . nil)
;;    (neo-window-width . 50)
;;   )
;;   )

;; Migrated to use-package
(use-package treemacs
  :ensure t
  :demand t
  :bind (("C-x n" . treemacs-add-and-display-current-project-exclusively))
  :custom
  ;; (treemacs-no-png-images t)
  ;; (treemacs-resize-icons 10)
  (treemacs-hide-dot-git-directory nil)
  (treemacs-file-watch-mode nil) ;; ファイルウォッチを無効化（リモートでは重い）
  (treemacs-file-follow-delay 2.0) ;; 更新頻度を下げる
  :config
  (treemacs-resize-icons 10)
  (treemacs-follow-mode nil))

;; (leaf dirvish
;;   :ensure t
;;   :init
;;   (dirvish-override-dired-mode)

;;   :custom
;;   ;; 最小限の設定
;;   ((dirvish-side-width . 30)
;;    (dirvish-reuse-session . nil)  ; セッション再利用を無効化
;;    (dirvish-emerge-groups . nil)  ; グループ化を無効化
;;    )

;;   :config
;;   ;; 表示する属性（通常時）
;;   (setq dirvish-attributes
;;         '(file-size collapse subtree-state vc-state git-msg))

;;   ;; アイコン設定（オプション）
;;   ;; all-the-iconsがインストールされている場合
;;   (when (featurep 'all-the-icons)
;;     (push 'all-the-icons dirvish-attributes))

;;   ;; プレビュー設定
;;   (setq dirvish-preview-dispatchers
;;         '(image gif video audio epub pdf archive))

;;   :bind (("<f5>" . dirvish-side)
;;          ("C-c d" . dirvish))
;;   )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 05_scratch-log.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package scratch-log
  :ensure t
  :demand t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 05_yasnippet.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package yasnippet
  :ensure t
  :demand t
  :config
  (yas-global-mode 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 07_undo-tree.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package undo-tree
  :ensure t
  :bind (("C-M-/" . undo-tree-redo)
         ("C-/" . undo-tree-undo))
  :custom
  (undo-tree-auto-save-history nil)
  :config
  (global-undo-tree-mode t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 08_flycheck.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package flycheck
  :ensure t)

;; (leaf flycheck-pos-tip
;;   :ensure t
;;   :require t
;;   :after flycheck
;;   :config
;;   (flycheck-pos-tip-mode)
;;   )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 08_quickrun.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package quickrun
  :ensure t
  :bind ("C-q" . quickrun))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 11_expand-region.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package expand-region
  :ensure t
  :bind (("C-," . er/expand-region)
         ("C-<" . er/contract-region))
  :config
  (transient-mark-mode t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 13_rainbow-delimiter.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode)
  :demand t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 14_open-junk-file.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (leaf open-junk-file
;;   :ensure t
;;   :bind (("C-x C-j" . open-junk-file))
;;   :setq ((open-junk-file-format . "~/.emacs.d/junk/%Y/%m/%Y-%m-%d-%H%M%S.")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 15_ivy.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package ivy
  :ensure t)

(use-package all-the-icons-ivy-rich
  :ensure t
  :after ivy)

(use-package ivy-rich
  :ensure t
  :after ivy
  :bind (("C-x b" . ivy-switch-buffer)
         ("C-;" . ivy-switch-buffer))
  :config
  (all-the-icons-ivy-rich-mode 1)
  (ivy-rich-mode 1)
  (setq ivy-use-virtual-buffers t))

(use-package ivy-hydra
  :ensure t
  :after ivy)

(use-package swiper
  :ensure t
  :after ivy
  :bind (("C-s" . swiper-isearch))
  :config
  (ivy-rich-mode 1))

(use-package counsel
  :ensure t
  :after ivy
  :bind (("M-x" . counsel-M-x)
         ("M-y" . counsel-yank-pop)
         ("C-M-z" . counsel-fzf)
         ("C-M-r" . counsel-recentf)
         ("C-x C-b" . counsel-ibuffer)
         ("C-M-f" . counsel-rgrubyb)
         ("C-c i" . counsel-imenu))
  :config
  (counsel-mode 1)
  :hook
  (counsel-mode . (lambda () (whitespace-mode -1))))

(use-package prescient
  :ensure t
  :config
  (setq prescient-aggressive-file-save t)
  (setq prescient-save-file (locate-user-emacs-file "prescient"))
  (prescient-persist-mode 1))

(use-package ivy-prescient
  :ensure t
  :after (prescient ivy)
  :custom
  (ivy-prescient-retain-classic-highlighting t)
  :config
  (ivy-prescient-mode 1))

(use-package ivy-yasnippet
  :ensure t
  :demand t
  :after yasnippet
  :bind (("C-c y" . ivy-yasnippet)
         ("C-c C-y" . ivy-yasnippet)))

;; (leaf vertico
;;   :doc "VERTical Interactive COmpletion"
;;   :ensure t
;;   :global-minor-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_company-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package company
  :ensure t
  :bind ((:map company-active-map
          ("M-n" . nil)
          ("M-p" . nil)
          ("C-s" . company-filter-candidates)
          ("C-n" . company-select-next)
          ("C-p" . company-select-previous)
          ("<tab>" . company-complete-selection))
         (:map company-search-map
          ("C-n" . company-select-next)
          ("C-p" . company-select-previous))
         )
  :custom
  (company-idle-delay 0)
  (company-minimum-prefix-length 1)
  (company-transformers '(company-sort-by-occurrence))
  :config
  (global-company-mode 1)
  ;; (add-to-list 'company-backends 'company-yasnippet)
  )

;; (use-package company-box
;;   :ensure t
;;   :after (all-the-icons company)
;;   :hook (company-mode . company-box-mode)
;;   :custom
;;   (company-box-icons-alist 'company-box-icons-all-the-icons)
;;   (company-box-doc-enable t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_csharp-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package csharp-mode
  :ensure t
  :mode ("\\.cs\\'" "\\.csx\\'"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_elixir-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(leaf elixir-mode
;;  :ensure t
;;  :mode ("\\.elixir2\\'" "\\.ex$" "\\.exs$")
;;  :config
;;  (add-hook 'elixir-mode-hook
;;            '(lambda nil
;;               (company-mode t)
;;               (dumb-jump-mode t)
;;               (yas-minor-mode t)))
;;  (with-eval-after-load 'elixir-mode
;;    (add-to-list 'elixir-mode-hook
;;                 (defun auto-activate-ruby-end-mode-for-elixir-mode nil
;;                   (set
;;                    (make-variable-buffer-local 'ruby-end-expand-keywords-before-re)
;;                    "\\(?:^\\|\\s-+\\)\\(?:do\\)")
;;                   (set
;;                    (make-variable-buffer-local 'ruby-end-check-statement-modifiers)
;;                    nil)
;;                   (ruby-end-mode 1)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_go-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package go-mode
  :ensure t
  :mode ("\\.go\\'")
  :bind (:map go-mode-map
         ("C-c C-r" . go-remove-unused-imports)
         ("M-." . godef-jump)
         ("M-," . pop-tag-mark)
         ("C-c C-i" . go-import-add))
  :hook ((go-mode . company-mode)
         (go-mode . dumb-jump-mode)
         (go-mode . yas-minor-mode)
         (go-mode . (lambda () (setq tab-width 2)))
         (before-save . gofmt-before-save))
  :config
  (setq gofmt-command "goimports"))

(use-package go-eldoc
  :ensure t
  :after go-mode
  :hook (go-mode . go-eldoc-setup))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_graphql-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package graphql-mode
  :ensure t
  :mode ("\\.graphql\\'"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_json-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package json-mode
  :ensure t
  :mode ("\\.json$")
  :hook (json-mode . (lambda ()
                       (make-local-variable 'js-indent-level)
                       (setq js-indent-level 2))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_lsp-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq tsserver-args (list "--stdio" "--tsserver-path" (expand-file-name "~/.nvm/versions/node/v24.2.0/lib/node_modules/typescript/lib")))
;; Migrated to use-package
(use-package lsp-mode
  :ensure t
  :custom
  (lsp-clients-typescript-server-args tsserver-args)
  :config
  ;; (lsp-register-client
  ;;   (make-lsp-client :new-connection (lsp-tramp-connection "rust-analyzer")
  ;;                    :major-modes '(rustic-mode)
  ;;                    :remote? t
  ;;                    :server-id 'rust-analyzer-remote))
  :hook
  ;; (web-mode . lsp-deferred)
  (go-mode . lsp-deferred)
  ;; (typescript-mode . lsp-deferred)
  ;; (ruby-mode . lsp-deferred)
  ;; (terraform-mode . lsp-deferred)
  )

;; Migrated to use-package
(use-package lsp-ui
  :ensure t
  :demand t
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-doc-use-childframe nil)
  (lsp-ui-doc-use-webkit t)
  ;; (lsp-ui-flycheck-enable nil)
  (lsp-ui-peek-enable t)
  (lsp-ui-peek-fontify 'on-demand) ;; never, on-demand, or always
  (lsp-ui-imenu-enable nil)
  (lsp-ui-imenu-kind-position 'top)
  (lsp-ui-sideline-enable nil)
  (lsp-typescript-format-enable nil)
  (lsp-typescript-format-insert-space-after-semicolon-in-for-statements nil))

;; Migrated to use-package
(use-package eglot
  :ensure t
  :demand t
  :config
  ;; (add-to-list 'eglot-server-programs
  ;;            `(terraform-mode . ("terraform-ls" "serve" "--port" :autoport)))
  (add-to-list 'eglot-server-programs '(web-mode . ("typescript-language-server" "--stdio")))
  ;; (add-to-list 'eglot-server-programs '(ruby-mode . ("bundle" "exec" "rubocop" "--lsp")))
  :hook
  (web-mode . eglot-ensure)
  (ruby-mode . eglot-ensure)
  ;; (go-mode . eglot-ensure)
  ;; (terraform-mode . eglot-ensure)
  )

;; for python
;; (leaf lsp-pyright
;;   :ensure t
;;   :hook
;;   (python-mode-hook . lsp-deferred)
;; )

;; (leaf lsp-pyright
;;   :ensure t
;;   :hook (python-mode-hook . (lambda ()
;;                               (require 'lsp-pyright)
;;                               (lsp-deferred))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_magit.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package magit
  :ensure t
  :demand t
  :bind (("C-x m" . magit-status))
  :config
  (setq-default magit-auto-revert-mode nil)
  (eval-after-load "vc"
    '(remove-hook 'find-file-hooks 'vc-find-file-hook)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_markdown-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . gfm-mode)
  :custom
  (markdown-fontify-code-blocks-natively t)
  (markdown-header-scaling t)
  (markdown-indent-on-enter 'indent-and-new-item)
  (markdown-list-indent-width 2)
  :bind (:map markdown-mode-map
         ("<S-tab>" . markdown-promote-list-item)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_other-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package fzf
  :ensure t)

;; Migrated to use-package
(use-package highlight-symbol
  :ensure t)

;; Migrated to use-package
(use-package erlang
  :ensure t)

;; Migrated to use-package
(use-package nginx-mode
  :ensure t)

;; Migrated to use-package
(use-package dockerfile-mode
  :ensure t
  :demand t)

;; Migrated to use-package
(use-package toml-mode
  :ensure t)

;; Migrated to use-package
(use-package yaml-mode
  :ensure t
  :hook (yaml-mode . whitespace-mode))

;; Migrated to use-package
(use-package highlight-indent-guides
  :ensure t
  ;; :hook
  ;; (yaml-mode . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-auto-enabled t)
  (highlight-indent-guides-responsive t)
  (highlight-indent-guides-method 'character))

;; Migrated to use-package
(use-package volatile-highlights
  :ensure t
  :demand t
  :config
  (volatile-highlights-mode)
  (with-no-warnings
    (when (fboundp 'pulse-momentary-highlight-region)
      (defun my-vhl-pulse (beg end &optional _buf face)
        "Pulse the changes."
        (pulse-momentary-highlight-region beg end face))
      (advice-add #'vhl/.make-hl :override #'my-vhl-pulse))))

;; Migrated to use-package
(use-package ansible
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_protobuf-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package protobuf-mode
  :ensure t
  :mode ("\\.proto\\'")
  :hook ((protobuf-mode . company-mode)
         (protobuf-mode . dumb-jump-mode)
         (protobuf-mode . yas-minor-mode)
         (protobuf-mode . (lambda () (setq tab-width 2)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_ruby-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Migrated to use-package
(use-package ruby-mode
  :ensure t
  :demand t
  :init
  (defun ruby-beautify-buffer ()
    (interactive)
    (let (p rb)
      (setq p (point)
            rb (buffer-string))
      (with-temp-buffer
        (insert rb)
        (call-process-region
         (point-min)
         (point-max)
         "rbeautify" t t)
        (setq rb (buffer-string)))
      (erase-buffer)
      (insert rb)
      (goto-char p)))
  :bind (("C-c C-v f" . ruby-beautify-buffer)
         ("C-M-n" . ruby-end-of-block)
         ("C-M-p" . ruby-beginning-of-block))
  :mode ("\\.rb$"
         "\\.jb$"
         "\\.ruby$"
         "\\.rake$"
         "Rakefile$"
         "\\.gemspec$"
         "\\.ru$"
         "Gemfile$"
         "Guardfile$"
         "\\.jbuilder$"
         "Schemafile$")
  :custom
  (lsp-diagnostic-package :none)
  :hook ((ruby-mode . company-mode)
         (ruby-mode . dumb-jump-mode)
         (ruby-mode . ruby-end-mode)
         (ruby-mode . yas-minor-mode)
         (ruby-mode . rainbow-delimiters-mode)
         (ruby-mode . copilot-mode)))

;; Migrated to use-package
(use-package rspec-mode
  :ensure t
  :demand t
  :config
  (defun rspec-specize-file-name-advice (args)
    "controller からテストファイルを探索する時に request spec に移動するパッチ"
    (let ((file-name (nth 0 args)))
      (setq file-name (string-replace "/controllers/" "/requests/" file-name))
      (setq file-name (string-replace "_controller.rb" ".rb" file-name))
      (list file-name)))

  (defun rspec-targetize-file-name-advice (args)
    "request spec からプロダクトコードを探索する時に controller に移動するパッチ"
    (let ((file-name (nth 0 args)) (extension (nth 1 args)))
      (setq file-name (string-replace "/requests/" "/controllers/" file-name))
      (setq file-name (string-replace "_spec" "_controller" file-name))
      (list file-name extension)))

  (advice-add 'rspec-specize-file-name :filter-args 'rspec-specize-file-name-advice)
  (advice-add 'rspec-targetize-file-name :filter-args 'rspec-targetize-file-name-advice))

;; (leaf rubocop
;;   :ensure t
;;   :require t
;;   :custom
;;   ((rubocop-prefer-system-executable . t))
;;   :hook
;;   ((ruby-mode-hook . rubocop-mode))
;;   )

(with-eval-after-load 'ruby-mode
  (setq ruby-insert-encoding-magic-comment nil)
  (setq ruby-deep-indent-paren-style nil)
  (setq ruby-deep-indent-paren-style nil)
  (defadvice ruby-indent-line (after unindent-closing-paren activate)
    (let ((column (current-column))
          indent
          offset)
      (save-excursion
        (back-to-indentation)
        (let ((state (syntax-ppss)))
          (setq offset (- column
                          (current-column)))
          (when (and
                 (eq
                  (char-after)
                  41)
                 (not (zerop
                       (car state))))
            (goto-char (cadr state))
            (setq indent (current-indentation)))))
      (when indent
        (indent-line-to indent)
        (when (> offset 0)
          (forward-char offset))))))

;; Migrated to use-package
(use-package ruby-end
  :ensure t
  :demand t)

(use-package slim-mode
  :ensure t
  :mode ("\\.slim$"
         "\\.slime$"))

(use-package haml-mode
  :ensure t
  :demand t)

(use-package ruby-hash-syntax
  :ensure t
  :demand t)

(use-package ruby-refactor
  :ensure t
  :demand t)

;; (leaf rvm
;;   :ensure t
;;   :if (eq system-type 'darwin)
;;   :commands rvm-use-default
;;   :config
;;   (rvm-use-default)
;;   )

;; Migrated to use-package
(use-package rbenv
  :ensure t
  :demand t
  ;; :if (eq system-type 'gnu/linux)
  :config
  (global-rbenv-mode)
  :custom
  (rbenv-installation-dir "~/.rbenv"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_rust-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package rustic
  :ensure t
  :mode ("\\.rs$")
  :custom
  ;; debug
  (lsp-print-io nil)
  (lsp-trace nil)
  (lsp-print-performance nil)
  ;; general
  ;; (lsp-auto-guess-root t)
  ;; (lsp-document-sync-method 'incremental) ;; always send incremental document
  (lsp-response-timeout 5)
  (lsp-prefer-flymake 'flymake)
  ;; (lsp-enable-completion-at-point nil)
  (rustic-format-on-save t)
  (rustic-lsp-format t)
  (rustic-format-trigger nil)
  (rustic-lsp-client 'eglot)
  :hook
  ((rustic-mode . company-mode)
   (rustic-mode . dumb-jump-mode)
   (rustic-mode . yas-minor-mode)
   (rustic-mode . rainbow-delimiters-mode)
   (rustic-mode . copilot-mode))
  :bind (:map rustic-mode-map
         ("C-M-n" . rustic-end-of-defun)
         ("C-M-p" . rustic-beginning-of-defun))
  :config
  (remove-hook 'rustic-mode-hook 'flycheck-mode)
  ;; (add-hook 'eglot--managed-mode-hook (lambda () (flymake-mode -1)))
  (add-to-list 'eglot-server-programs
               `(rustic-mode . ("rust-analyzer" :initializationOptions
                                ( :procMacro (:enable t)
                                  :cargo ( :buildScripts (:enable t)
                                           :features "all")
                                  :completion ( :snippets ( :custom
                                                            ( :Ok ( :postfix "ok"
                                                                    :body "Ok(${receiver})"
                                                                    :description "Ok($expr)"
                                                                    :scope "expr")
                                                              :Some ( :postfix "some"
                                                                      :body "Some(${receiver})"
                                                                      :description "Some($expr)"
                                                                      :scope "expr")))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_scss-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package scss-mode
  :ensure t
  :mode ("\\.scss$")
  :init
  (defun scss-custom ()
    "scss-mode-hook"
    (setq-local css-indent-offset 2)
    (setq-local scss-compile-at-save nil))
  :hook (scss-mode . scss-custom))

;; Migrated to use-package
(use-package rainbow-mode
  :ensure t
  :demand t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_terraform-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package terraform-mode
  :ensure t
  :mode ("\\.tf\\'" "\\.hcl\\'")
  :demand t
  :custom
  (tab-width 2)
  (terraform-format-on-save t)
  :hook ((terraform-mode . company-mode)
         (terraform-mode . dumb-jump-mode)
         (terraform-mode . yas-minor-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_vue-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (leaf vue-mode
;;   :ensure t
;;   :mode ("\\.vue\\'")
;;   :config
;;   (with-eval-after-load 'vue-mode
;;     (setq mmm-submode-decoration-level 0)
;;     (setq indent-tabs-mode nil
;;           js-indent-level 2
;;           typescript-indent-level 2)
;;     (add-hook 'vue-mode-hook #'add-node-modules-path)
;;     (add-hook 'vue-mode-hook 'yas-minor-mode)
;;     (add-hook 'vue-mode-hook 'flycheck-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_web-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package typescript-mode
  :ensure t
  :demand t)

;; Migrated to use-package
(use-package web-mode
  :ensure t
  :demand t
  :mode ("\\.phtml$"
         "\\.tpl\\.php$"
         "\\.jsp$"
         "\\.as[cp]x$"
         "\\.erb$"
         "\\.html?$"
         "\\.css?$"
         "\\.jsx$"
         "\\.m?js$"
         "\\.tsx$"
         "\\.ts$"
         "\\.astro$")
  :custom
  (auto-save-default nil)
  (web-mode-markup-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-code-indent-offset 2)
  (web-mode-attr-indent-offset 2)
  (web-mode-enable-auto-pairing t)
  (web-mode-enable-auto-closing t)
  :hook ((web-mode . company-mode)
         (web-mode . dumb-jump-mode)
         (web-mode . yas-minor-mode)
         (web-mode . copilot-mode))
  :config
  (setq-default indent-tabs-mode nil)
  ;; (setq-default web-mode-comment-formats (remove '("javascript" . "/*") web-mode-comment-formats))
  (add-to-list 'web-mode-comment-formats '("javascript" . "//"))
  (add-to-list 'web-mode-comment-formats '("jsx" . "//" ))
  (add-to-list 'web-mode-comment-formats '("tsx" . "//" ))
  (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-ternary" . nil)))

(use-package nvm
  :ensure t
  :demand t
  :config
  (nvm-use "24.2.0"))

(use-package prettier
  :ensure t
  :after (nvm web-mode)
  :demand t
  :hook (web-mode . prettier-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package ace-jump-mode
  :ensure t
  :demand t)
;; Migrated to use-package
(use-package ace-window
  :ensure t
  :demand t
  :bind ("C-x a" . ace-window)
  :custom
  (aw-keys '(?a ?b ?k ?l ?g ?h ?j ?k)))

;; Migrated to use-package
(use-package projectile
  :ensure t
  :demand t
  :config
  (projectile-mode +1))

;; Migrated to use-package
(use-package ddskk
  :ensure t
  :bind (("C-x C-j" . skk-mode)
         ("C-x j"   . skk-mode))
  :init
  (defvar dired-bind-jump nil)  ; dired-xがC-xC-jを奪うので対処しておく
  (defun my/skk-azik-disable-tU ()
    "ddskkのazikモードが`tU'を`っ'として扱うのを抑制する."
    (setq skk-rule-tree (skk-compile-rule-list
                         skk-rom-kana-base-rule-list
                         (skk-del-alist "tU" skk-rom-kana-rule-list))))
  :custom
  (skk-use-azik nil)      ; AZIKを使用する
  (skk-azik-keyboard-type 'jp106)
  (skk-tut-file nil)
  (skk-server-host "localhost")
  (skk-server-portnum 1178)
  (skk-egg-like-newline t)      ; 変換時にリターンでは改行しない
  (skk-japanese-message-and-error t)      ; メッセージを日本語にする
  (skk-auto-insert-paren t)      ; 対応する括弧を自動挿入
  (skk-check-okurigana-on-touroku t)
  (skk-show-annotation t)      ; アノテーションを表示
  (skk-anotation-show-wikipedia-url t)
  (skk-show-tooltip nil)    ; 変換候補をインライン表示しない
  (skk-isearch-start-mode 'latin) ; isearch時にSKKをオフ
  (skk-henkan-okuri-strictly nil)    ; 送り仮名を考慮した変換候補
  (skk-process-okuri-early nil)
  (skk-status-indicator 'minor-mode)
  :hook
  (skk-azik-load . my/skk-azik-disable-tU))
;; Migrated to use-package
(use-package csv-mode
  :ensure t
  :demand t)

;; Migrated to use-package
(use-package lua-mode
  :ensure t
  :demand t)

;; Migrated to use-package
(use-package tree-sitter
  ;; :hook
  ;; (tree-sitter-after-on . tree-sitter-hl-mode)
  ;; :config
  ;; (global-tree-sitter-mode)
  ;; (tree-sitter-require 'tsx)
  :custom
  (treesit-extra-load-path '("~/.emacs.d/tree-sitter/")))

(leaf copilot
  :el-get (copilot
           :type github
           :pkgname "copilot-emacs/copilot.el"
           )
  :require t
  :config
  (leaf editorconfig
    :ensure t
    :require t
    )
  (leaf s
    :ensure t
    :require t
    )
  (leaf dash
    :ensure t
    :require t
    )
  (defun my/copilot-tab ()
    (interactive)
    (or (copilot-accept-completion)
        (indent-for-tab-command)))

  (with-eval-after-load 'copilot
    (define-key copilot-mode-map (kbd "<tab>") #'my/copilot-tab))
  )

;; Migrated to use-package
(use-package request
  :ensure t
  :demand t)

;; Migrated to use-package
(use-package copilot-chat
  :ensure t
  :demand t
  :after (markdown-mode chatgpt-shell))

;; Migrated to use-package
(use-package string-inflection
  :ensure t
  :demand t)

;; Claude Code
;; Migrated to use-package
;; Claude Code
(use-package vterm
  ;; requirements: brew install cmake libvterm libtool
  :ensure t
  :custom
  (vterm-shell "/bin/zsh")
  (vterm-max-scrollback 10000)
  (vterm-buffer-name-string "vterm: %s")
  ;; delete "C-h", add <f1> and <f2>
  (vterm-keymap-exceptions
   '("<f1>" "<f2>" "C-c" "C-x" "C-u" "C-g" "C-l" "M-x" "M-o" "C-v" "M-v" "M-y"))
  (vterm-tramp-shells '(("ssh"  login-shell "/bin/zsh")
                        ("scp"  login-shell "/bin/zsh")
                        ("scpx" login-shell "/bin/zsh")
                        ("sshx" login-shell "/bin/zsh")))
  :config
  ;; Workaround of not working counsel-yank-pop
  ;; https://github.com/akermu/emacs-libvterm#counsel-yank-pop-doesnt-work
  (advice-add 'counsel-yank-pop-action :around #'my/vterm-counsel-yank-pop-action)
  :hook
  (vterm-mode . (lambda () (whitespace-mode -1)))
  :bind (:map vterm-mode-map
         ("C-y" . vterm-yank)))

;; Migrated to use-package
(use-package vterm-toggle
  :ensure t
  :custom
  (vterm-toggle-scope 'project)
  :config
  ;; Show vterm buffer in the window located at bottom
  (add-to-list 'display-buffer-alist
               '((lambda(bufname _) (with-current-buffer bufname (equal major-mode 'vterm-mode)))
                 (display-buffer-reuse-window display-buffer-in-direction)
                 (direction . bottom)
                 (reusable-frames . visible)
                 (window-height . 0.4)))
  ;; Above display config affects all vterm command, not only vterm-toggle
  (defun my/vterm-new-buffer-in-current-window()
    (interactive)
    (let ((display-buffer-alist nil))
      (vterm))))

(use-package claude-code-ide
  :vc (:url "https://github.com/manzaltu/claude-code-ide.el" :rev :newest)
  :init
  :bind
  (("C-c m" . claude-code-ide-menu)
   ("C-c c p" . my/claude-code-toggle-plan-mode)
   )
  :custom
  (claude-code-ide-terminal-backend 'vterm)
  ;; (claude-code-ide-window-side 'bottom)
  ;; (claude-code-ide-window-hight 30)
  (claude-code-ide-vterm-anti-flicker t)
  :config
  (claude-code-ide-emacs-tools-setup)
  )
