;; Package initialization
(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")
                       ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
  (package-initialize))

;; use-package setup (built-in for Emacs 29+)
;; Imenuでuse-package宣言を拾う（consult-imenu対応）
(setq use-package-enable-imenu-support t)
(require 'use-package)
(setq use-package-always-ensure t)  ; Always ensure packages are installed

;; custom設定がinit.elに書き込まれないようにする
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(setq gc-cons-threshold (* 128 1024 1024))
(setq ring-bell-function 'ignore)

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

;; font
(set-face-attribute 'default nil :height 170)
(set-frame-font "HackGen-16")


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

(use-package mozc
  :if (eq system-type 'gnu/linux)
  :ensure t
  :bind* (("M-SPC" . toggle-input-method))
  :custom
  (default-input-method "japanese-mozc")
  (mozc-helper-program-name "mozc_emacs_helper")
  (mozc-leim-title "Mozc")
  :init
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
  :hook
  (mozc-mode . (lambda ()
                 (define-key mozc-mode-map "?" (lambda () (interactive) (mozc-insert-str "？")))
                 (define-key mozc-mode-map "," (lambda () (interactive) (mozc-insert-str "、")))
                 (define-key mozc-mode-map "." (lambda () (interactive) (mozc-insert-str "。"))))))

(use-package posframe
  :if (eq system-type 'gnu/linux)
  :ensure t)

(use-package mozc-cursor-color
  :if (eq system-type 'gnu/linux)
  :vc (:url "https://github.com/iRi-E/mozc-el-extensions" :main-file "mozc-cursor-color.el")
  :after mozc
  :config
  (setq mozc-cursor-color-alist
        '((direct . "#BD93F9")
          (read-only . "#84A0C6")
          (hiragana . "#CC3333"))))

(use-package mozc-cand-posframe
  :if (eq system-type 'gnu/linux)
  :ensure t
  :after (mozc posframe)
  :custom
  (mozc-candidate-style 'posframe))


(when (eq system-type 'gnu/linux)
  (defun my:select-mozc-tool ()
    "Narrow the only espy command in M-x."
    (interactive)
    (minibuffer-with-setup-hook (lambda () (insert "my:mozc "))
      (call-interactively #'execute-extended-command)))

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
;; Migrated to use-package
(use-package modus-themes
  :ensure t
  :bind ("<f5>" . modus-themes-toggle)
  :init
  (load-theme 'modus-vivendi-deuteranopia :no-confirm))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Vertico stack (vertico, orderless, marginalia, consult)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Persist minibuffer history
(use-package savehist
  :ensure t
  :init (savehist-mode 1))

;; Vertical interactive completion UI
(use-package vertico
  :ensure t
  :init (vertico-mode 1))

;; Flexible matching for completion
(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; Rich annotations in minibuffer
(use-package marginalia
  :ensure t
  :init (marginalia-mode 1))

;; Recent files for consult-recent-file
(use-package recentf
  :ensure t
  :init (recentf-mode 1)
  :custom
  (recentf-max-saved-items 2000)
  (recentf-auto-cleanup 'never))

;; Consult: commands replacing Counsel/Swiper
(use-package consult
  :ensure t
  :bind (("C-x b" . consult-buffer)
         ("C-s"   . consult-line)
         ("M-y"   . consult-yank-pop)
         ("C-M-r" . consult-recent-file)
         ("C-c i" . consult-imenu))
  :init
  (with-eval-after-load 'projectile
    (setq consult-project-function (lambda (_) (projectile-project-root)))))

;; affe: async fast find/grep (fd/rg)
(use-package affe
  :ensure t
  :bind (("C-M-z" . affe-find)
         ("C-M-f" . affe-grep))
  :config
  (require 'orderless)
  (defun my/affe-orderless-regexp-compiler (input _type _ignore)
    (setq input (orderless-pattern-compiler input))
    (cons input (lambda (str) (orderless--highlight input str))))
  (setq affe-regexp-compiler #'my/affe-orderless-regexp-compiler))

;; Embark: act on candidates
(use-package embark
  :ensure t
  :bind (("C-." . embark-act)
         ("C-;" . embark-dwim)
         ;; C-h はプレフィックスではない設定のため別キーに退避
         ("C-c B" . embark-bindings)
         ("C-c h" . embark-prefix-help-command))
  :init
  (setq prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult
  :ensure t
  :after (embark consult)
  :hook (embark-collect-mode . consult-preview-at-point-mode))

;; Corfu/Cape (initially not enabled globally to avoid conflict with Company)
(use-package corfu
  :ensure t
  :custom (corfu-auto t)
  (corfu-auto-delay 0)
  (corfu-auto-prefix 1))

(use-package cape
  :ensure t
  :init
  (defun my/setup-cape-capfs ()
    (add-hook 'completion-at-point-functions #'cape-file 90 t)
    (add-hook 'completion-at-point-functions #'cape-dabbrev 95 t)
    (add-hook 'completion-at-point-functions #'cape-keyword 95 t)
    (add-hook 'completion-at-point-functions #'cape-symbol 95 t)
    (when (fboundp 'cape-yasnippet)
      (add-hook 'completion-at-point-functions #'cape-yasnippet 90 t)))
  ;; すべてのテキスト/プログラミングバッファで CAPF を補強
  :hook ((prog-mode . my/setup-cape-capfs)
         (text-mode . my/setup-cape-capfs)))

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
  (setq dumb-jump-selector 'completing-read)
  (bind-keys :map dumb-jump-mode-map
             ("C-M-p" . nil))
  :hook
  (xref-backend-functions . dumb-jump-xref-activate))

;; Migrated to use-package
(use-package smart-jump
  :ensure t
  :bind
  ("M-." . smart-jump-go)
  :custom
  (dumb-jump-mode t)
  (dumb-jump-selector 'completing-read) ;; completing-readに移行
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

(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

;; Dirvish（Dired強化）をサイドバーとして利用（Treemacs 代替）
(use-package dirvish
  :ensure t
  :init
  (dirvish-override-dired-mode)
  :custom
  (dirvish-hide-details t)
  (dirvish-mode-line-format '(:left (sort symlink) :right (omit yank index)))
  ;; アイコン + サブツリー表示（サイドも同様に最小構成）
  (dirvish-attributes '(subtree-state nerd-icons collapse file-time file-size))
  (dirvish-side-attributes '(subtree-state nerd-icons))
  (dirvish-subtree-state-style 'nerd)
  (dirvish-nerd-icons-height 0.9)
  ;; よく使う場所へのクイックアクセス
  (dirvish-quick-access-entries
   `(("h" "~/"                  "Home")
     ("e" ,user-emacs-directory "Emacs user directory")
     ("p" "/sshx:server:~/workspace/lecto/primeape" "primeape")))
  ;; 左側に固定表示
  (dirvish-side-display-alist '((side . left)))
  :config
  ;; カーソル位置のファイルに追随
  (dirvish-side-follow-mode 1)
  ;; Treemacs の "W" 相当: サイドバー幅をトグル
  (defcustom my/dirvish-side-widths '(30 50 70 100)
    "Toggle 候補にする Dirvish サイドバーの幅（カラム数）。"
    :type '(repeat integer))

  (defun my/dirvish-side-toggle-width ()
    "Dirvish サイドウィンドウの幅を `my/dirvish-side-widths' でトグルする。"
    (interactive)
    (let ((win (ignore-errors (with-no-warnings (dirvish-side--session-visible-p)))))
      (unless win (user-error "No visible dirvish-side window"))
      (with-selected-window win
        (let* ((cur (window-width))
               (cands (or my/dirvish-side-widths (list cur)))
               (next (or (seq-find (lambda (w) (> w cur)) cands)
                         (car cands)))
               (delta (- next cur)))
          (let ((window-size-fixed nil))
            (ignore-errors (enlarge-window-horizontally delta)))
          ;; 新規オープン時の既定幅も合わせておく
          (setq dirvish-side-width next)
          (message "Dirvish side width: %d" next)))))
  :bind (("C-x n" . dirvish-side)
         :map dirvish-mode-map
         ("W" . my/dirvish-side-toggle-width)
         ("TAB" . dirvish-subtree-toggle)
         ("<backtab>" . dirvish-subtree-up)
         ("<mouse-1>" . dirvish-subtree-toggle-or-open)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 05_scratch-log.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package scratch-log
  :ensure t)

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
;; 15_ivy.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
;; Ivy/Counsel/Swiper stack removed (migrated to Vertico/Consult)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_completion (corfu)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
;; Corfu をグローバル有効化（company の代替）
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode 1)
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0)
  (corfu-auto-prefix 1)
  (corfu-cycle t))

;; 候補ドキュメントのポップアップ表示
(use-package corfu-popupinfo
  :ensure nil
  :after corfu
  :hook (corfu-mode . corfu-popupinfo-mode)
  :custom
  (corfu-popupinfo-delay 0.2)
  (corfu-popupinfo-max-width 80)
  (corfu-popupinfo-max-height 20)
  :bind (:map corfu-map
              ("M-n" . corfu-popupinfo-scroll-up)
              ("M-p" . corfu-popupinfo-scroll-down)
              ("M-d" . corfu-popupinfo-toggle)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_csharp-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package csharp-mode
  :ensure t
  :mode ("\\.cs\\'" "\\.csx\\'"))

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
  :hook ((go-mode . yas-minor-mode)
         (go-mode . dumb-jump-mode)
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
  (lsp-completion-provider :capf)
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
  :config
  ;; (add-to-list 'eglot-server-programs
  ;;            `(terraform-mode . ("terraform-ls" "serve" "--port" :autoport)))
  (add-to-list 'eglot-server-programs '(web-mode . ("typescript-language-server" "--stdio")))
  ;; (add-to-list 'eglot-server-programs '(ruby-mode . ("bundle" "exec" "rubocop" "--lsp")))
  :hook
  (web-mode . eglot-ensure)
  (ruby-mode . eglot-ensure)
  (rustic-mode . eglot-ensure)
  ;; (go-mode . eglot-ensure)
  ;; (terraform-mode . eglot-ensure)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_magit.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package magit
  :ensure t
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
  )

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
  :hook ((protobuf-mode . yas-minor-mode)
         (protobuf-mode . dumb-jump-mode)
         (protobuf-mode . (lambda () (setq tab-width 2)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_ruby-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Migrated to use-package
(use-package ruby-mode
  :ensure t
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
  :hook ((ruby-mode . dumb-jump-mode)
         (ruby-mode . ruby-end-mode)
         (ruby-mode . yas-minor-mode)
         (ruby-mode . rainbow-delimiters-mode)
         (ruby-mode . copilot-mode)))

;; Migrated to use-package
(use-package rspec-mode
  :ensure t
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
  )

(use-package slim-mode
  :ensure t
  :mode ("\\.slim$"
         "\\.slime$"))

(use-package haml-mode
  :ensure t
  :mode ("\\.haml\\'"))

(use-package ruby-hash-syntax
  :ensure t
  )

(use-package ruby-refactor
  :ensure t
  )

;; Migrated to use-package
(use-package rbenv
  :ensure t
  :init
  (global-rbenv-mode 1)                        ;; モードライン/環境切替を有効化
  :hook (ruby-mode . rbenv-use-corresponding)  ;; プロジェクトの .ruby-version を優先
  :custom
  (rbenv-installation-dir "~/.rbenv")
  (rbenv-show-active-ruby-in-modeline t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_rust-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 一部のファイルが "-*- mode: rustic; -*-" を使う場合に備えてエイリアスを定義
;; rustic はメジャーモード関数名ではなく、実体は rustic-mode
(defalias 'rustic 'rustic-mode)

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
  ((rustic-mode . dumb-jump-mode)
   (rustic-mode . yas-minor-mode)
   (rustic-mode . rainbow-delimiters-mode)
   (rustic-mode . copilot-mode))
  :bind (:map rustic-mode-map
         ("C-M-n" . rustic-end-of-defun)
         ("C-M-p" . rustic-beginning-of-defun))
  :config
  (remove-hook 'rustic-mode-hook 'flycheck-mode)
  ;; (add-hook 'eglot--managed-mode-hook (lambda () (flymake-mode -1)))
  (with-eval-after-load 'eglot
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
                                                                        :scope "expr"))))))))))

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
  :custom
  (tab-width 2)
  (terraform-format-on-save t)
  :hook ((terraform-mode . yas-minor-mode)
         (terraform-mode . dumb-jump-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_web-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Migrated to use-package
(use-package typescript-mode
  :ensure t
  )

;; Migrated to use-package
(use-package web-mode
  :ensure t
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
  :hook ((web-mode . yas-minor-mode)
         (web-mode . dumb-jump-mode)
         (web-mode . my/nvm-use-24)
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
  :commands (nvm-use)
  :init
  (defun my/nvm-use-24 ()
    (interactive)
    (ignore-errors (nvm-use "24.2.0"))))

(use-package prettier
  :ensure t
  :after (nvm web-mode)
  :hook (web-mode . prettier-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
  )

;; Migrated to use-package
(use-package lua-mode
  :ensure t
  )

;; Migrated to use-package
(use-package tree-sitter
  ;; :hook
  ;; (tree-sitter-after-on . tree-sitter-hl-mode)
  ;; :config
  ;; (global-tree-sitter-mode)
  ;; (tree-sitter-require 'tsx)
  :custom
  (treesit-extra-load-path '("~/.emacs.d/tree-sitter/")))

(use-package editorconfig :ensure t)
(use-package s :ensure t)
(use-package dash :ensure t)
(use-package copilot
  :vc (:url "https://github.com/copilot-emacs/copilot.el" :branch "main")
  :commands (copilot-mode)
  :init
  (defun my/copilot-tab ()
    (interactive)
    (or (copilot-accept-completion)
        (indent-for-tab-command)))
  :config
  (define-key copilot-mode-map (kbd "<tab>") #'my/copilot-tab))

;; Migrated to use-package
(use-package request
  :ensure t
  )

;; Migrated to use-package
(use-package copilot-chat
  :ensure t
  :after (markdown-mode chatgpt-shell))

;; Migrated to use-package
(use-package string-inflection
  :ensure t
  )

;; Structured editing for pairs
(use-package puni
  :ensure t
  :defer t
  :init
  (puni-global-mode)
  (add-hook 'term-mode-hook #'puni-disable-puni-mode))

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
  ;; Counsel-specific workaround (guarded)
  ;; https://github.com/akermu/emacs-libvterm#counsel-yank-pop-doesnt-work
  (with-eval-after-load 'counsel
    (advice-add 'counsel-yank-pop-action :around #'my/vterm-counsel-yank-pop-action))
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
  :vc (:url "https://github.com/manzaltu/claude-code-ide.el")
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
