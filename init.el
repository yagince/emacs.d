;; <leaf-install-code>
(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
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
    (leaf-keywords-init)))
;; </leaf-install-code>

(setq gc-cons-threshold (* 128 1024 1024))
(setq ring-bell-function 'ignore)

;; Now you can use leaf!
(leaf leaf-convert :ensure t)
(leaf leaf-tree
  :ensure t
  :custom ((imenu-list-size . 30)
           (imenu-list-position . 'left)))

(leaf macrostep
  :ensure t
  :bind (("C-c e" . macrostep-expand)))

(leaf exec-path-from-shell
  :ensure t
  :require t
  :defun (exec-path-from-shell-initialize)
  :custom
  ((exec-path-from-shell-variables           . '("RUST_SRC_PATH"
                                                 "GOPATH"
                                                 "PATH")))
  :config
  (exec-path-from-shell-initialize)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 00_base.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ツールバーを非表示
(tool-bar-mode -1)
;; メニューバーを非表示
(menu-bar-mode -1)
;; C-x M-x などで英語モードに切り替える
(mac-auto-ascii-mode 1)

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
(set-frame-font "Ricty-17")
(set-fontset-font t 'japanese-jisx0208 "Ricty Diminished-17")
(add-to-list 'face-font-rescale-alist
             '(".*Ricty Diminished.*" . 1.1))

(when (eq system-type 'darwin) ; Mac OS X
  (set-fontset-font
   t 'symbol (font-spec :family "Apple Color Emoji") nil 'prepend)

  (add-to-list 'face-font-rescale-alist
               '(".*Apple Color Emoji.*" . 0.8))
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

(leaf all-the-icons
  :ensure t
  :custom ((all-the-icons-scale-factor . 1.0))
  :require t)

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 00_keybindings.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-unset-key (kbd "M-SPC"))
(global-set-key "\C-h" 'backward-delete-char)
(define-key global-map [?¥] [?\\])
(define-key global-map (kbd "C-z") nil)

(leaf bind-key
  :ensure t)

(leaf goto-chg
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

(leaf multiple-cursors
  :ensure t
  :require t
  )

(leaf anzu
  :ensure t
  :require t
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 01_grep.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(leaf rg
  :ensure t
  :bind (("M-s" . rg))
  )

(leaf wgrep
  :ensure t
  :custom ((wgrep-auto-save-buffer . t))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 02_cua.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 矩形モード
(cua-mode t)
(setq cua-enable-cua-keys nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 04_visual.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; タブ, 全角スペース, 行末空白表示
(defface my-face-b-1 '((t (:background "NavajoWhite4"))) nil) ; 全角スペース
(defface my-face-b-2 '((t (:background "gray10"))) nil) ; タブ
(defface my-face-u-1 '((t (:background "SteelBlue" :underline t))) nil) ; 行末空白
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)

(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("\t" 0 my-face-b-2 append)
     ("　" 0 my-face-b-1 append)
     ("[ \t]+$" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

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
(leaf modus-themes
  :ensure t
  :bind ("<f5>" . modus-themes-toggle)
  :init
  (load-theme 'modus-vivendi :no-confirm)
  :config
  )

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

(leaf highlight-symbol
  :ensure t
  :hook (prog-mode-hook
         (prog-mode-hook . highlight-symbol-nav-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 05_dumb_jump.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(leaf dumb-jump
  :ensure t
  :bind (("C-M-g" . dumb-jump-go)
         ("C-M-b" . dumb-jump-back)
         ("C-M-q" . dumb-jump-quick-look))
  :config
  (with-eval-after-load 'dumb-jump
    (setq dumb-jump-selector 'ivy)
    (bind-keys :map dumb-jump-mode-map
               ("C-M-p" . nil)))
  :hook
  (xref-backend-functions . dumb-jump-xref-activate)
  )

(leaf smart-jump
  :ensure t ivy
  :bind
  ("M-." . smart-jump-go)
  :custom
  (dumb-jump-mode . t)
  (dumb-jump-selector . 'ivy) ;; 候補選択をivyに任せます
  (dumb-jump-use-visible-window . nil)
  :config
  (smart-jump-setup-default-registers)
  )

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

(leaf neotree
  :ensure t
  :bind (("C-x n" . neotree-show))
  :config
  (with-eval-after-load 'neotree
    (setq neo-show-hidden-files t) ;; 隠しファイルをデフォルトで表示
    (setq neo-keymap-style 'concise)
    (setq neo-smart-open t)
    (setq neo-create-file-auto-open t)
    (setq neo-theme (if (display-graphic-p)
                        'icons 'arrow)))
  :custom
  ;; ((neo-window-fixed-size . nil))
  ((projectile-switch-project-action . 'neotree-projectile-action))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 05_scratch-log.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(leaf scratch-log
  :ensure t
  :require t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 05_yasnippet.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(leaf yasnippet
  :ensure t
  :require t
  :config
  (yas-global-mode 1)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 07_undo-tree.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(leaf undo-tree
  :ensure t
  :bind (
         ("C-M-/" . undo-tree-redo)
         ("C-/" . undo-tree-undo)
         )
  :custom
  (
   (undo-tree-auto-save-history . nil)
   )
  :config
  (global-undo-tree-mode t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 08_flycheck.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(leaf flycheck
  :ensure t
  :config
  )

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

(leaf quickrun
  :ensure t
  :bind (("C-q" . quickrun)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 11_expand-region.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(leaf expand-region
  :ensure t
  :bind (("C-," . er/expand-region)
         ("C-<" . er/contract-region))
  :config
  (transient-mark-mode t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 13_rainbow-delimiter.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(leaf rainbow-delimiters
  :ensure t
  :hook (prog-mode-hook)
  :require t)

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

(leaf ivy
  :ensure t
  :config
  (leaf all-the-icons-ivy-rich
    :ensure t)

  (leaf ivy-rich
    :ensure t
    :bind (("C-x b" . ivy-switch-buffer)
           ("C-;" . ivy-switch-buffer))
    :config
    (with-eval-after-load 'ivy-rich
      (all-the-icons-ivy-rich-mode 1)
      (ivy-rich-mode 1)
      (setq ivy-use-virtual-buffers t)))

  (leaf ivy-hydra
    :ensure t
    )

  (leaf swiper
    :ensure t
    :bind (("C-s" . swiper-isearch))
    :config
    (with-eval-after-load 'swiper
      (ivy-rich-mode 1)))

  (leaf counsel
    :ensure t
    :bind (("M-x" . counsel-M-x)
           ("M-y" . counsel-yank-pop)
           ("C-M-z" . counsel-fzf)
           ("C-M-r" . counsel-recentf)
           ("C-x C-b" . counsel-ibuffer)
           ("C-M-f" . counsel-rgrubyb)
           ("C-c i" . counsel-imenu))
    :config
    (with-eval-after-load 'counsel
      (counsel-mode 1)))

  (leaf prescient
    :doc "Better sorting and filtering(補完候補の使用履歴が新しいものを上に持ってきてくれる)"
    :req "emacs-25.1"
    :tag "extensions" "emacs>=25.1"
    :url "https://github.com/raxod502/prescient.el"
    :emacs>= 25.1
    :ensure t
    :commands (prescient-persist-mode)
    :custom `((prescient-aggressive-file-save . t)
              (prescient-save-file . ,(locate-user-emacs-file "prescient")))
    :global-minor-mode prescient-persist-mode)

  (leaf ivy-prescient
    :doc "prescient.el + Ivy"
    :req "emacs-25.1" "prescient-4.0" "ivy-0.11.0"
    :tag "extensions" "emacs>=25.1"
    :url "https://github.com/raxod502/prescient.el"
    :emacs>= 25.1
    :ensure t
    :after prescient ivy
    :custom ((ivy-prescient-retain-classic-highlighting . t))
    :global-minor-mode t)

  ;; (leaf ivy-yasnippet
  ;;   :ensure t
  ;;   :require t
  ;;   :after (yasnippet)
  ;;   :bind (("C-c y" . ivy-yasnippet)
  ;;          ("C-c C-y" . ivy-yasnippet)))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_company-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(leaf company-mode-conf
  :config
  (leaf company
    :ensure t
    :bind ((company-active-map
            ("M-n" . nil)
            ("M-p" . nil)
            ("C-s" . company-filter-candidates)
            ("C-n" . company-select-next)
            ("C-p" . company-select-previous)
            ("<tab>" . company-complete-selection))
           (company-search-map
            ("C-n" . company-select-next)
            ("C-p" . company-select-previous))
           ("C-x y" . company-yasnippet))
    :custom ((company-idle-delay . 0)
             (company-minimum-prefix-length . 1)
             (company-transformers . '(company-sort-by-occurrence)))
    :global-minor-mode global-company-mode
    :config
    ;; (add-to-list 'company-backends 'company-yasnippet)
    )

  (leaf company-box
    :ensure t
    :after all-the-icons company
    :hook (company-mode-hook)
    :custom ((company-box-icons-alist quote company-box-icons-all-the-icons)
             (company-box-doc-enable)))

  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_csharp-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(leaf csharp-mode
  :ensure t
  :mode ("\\.cs$'" "\\.csx$"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_elixir-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(leaf elixir-mode
  :ensure t
  :mode ("\\.elixir2\\'" "\\.ex$" "\\.exs$")
  :config
  (add-hook 'elixir-mode-hook
            '(lambda nil
               (company-mode t)
               (dumb-jump-mode t)
               (yas-minor-mode t)))
  (with-eval-after-load 'elixir-mode
    (add-to-list 'elixir-mode-hook
                 (defun auto-activate-ruby-end-mode-for-elixir-mode nil
                   (set
                    (make-variable-buffer-local 'ruby-end-expand-keywords-before-re)
                    "\\(?:^\\|\\s-+\\)\\(?:do\\)")
                   (set
                    (make-variable-buffer-local 'ruby-end-check-statement-modifiers)
                    nil)
                   (ruby-end-mode 1)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_go-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(leaf go-mode
  :ensure t
  :mode ("\\.go\\'")
  :config
  (with-eval-after-load 'go-mode
    (add-hook 'go-mode-hook
              '(lambda nil
                 (company-mode t)
                 (dumb-jump-mode t)
                 (yas-minor-mode t)
                 (setq tab-width 2)))
    (setq gofmt-command "goimports")
    (progn
      (bind-key "C-c C-r" #'go-remove-unused-imports go-mode-map nil)
      (bind-key "M-." #'godef-jump go-mode-map nil)
      (bind-key "M-," #'pop-tag-mark go-mode-map nil)
      (bind-key "C-c C-i" #'go-import-add go-mode-map nil)
      )

    (add-hook 'before-save-hook 'gofmt-before-save)
    (leaf go-eldoc
      :ensure t
      :config
      (add-hook 'go-mode-hook 'go-eldoc-setup))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_graphql-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(leaf graphql-mode
  :ensure t
  :mode ("\\.graphql\\'"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_json-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(leaf json-mode
  :ensure t
  :mode ("\\.json$")
  :config
  (add-hook 'json-mode-hook
            (lambda nil
              (make-local-variable 'js-indent-level)
              (setq js-indent-level 2))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_lsp-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(leaf lsp-mode
  :ensure t
  ;; :custom
  ;; (
  ;;  (lsp-eslint-auto-fix-on-save . t)
  ;;  )
  :config
  ;; (lsp-register-client
  ;;   (make-lsp-client :new-connection (lsp-tramp-connection "/home/natsuki/.cargo/bin/rust-analyzer")
  ;;                    :major-modes '(rustic-mode)
  ;;                    :remote? t
  ;;                    :server-id 'rust-analyzer-remote))
  (leaf lsp-ui
    :ensure t
    :custom
    (
     (lsp-ui-doc-enable            . t)
     (lsp-ui-doc-header            . t)
     (lsp-ui-doc-include-signature . t)
     (lsp-ui-doc-position          . 'at-point)
     (lsp-ui-doc-use-childframe    . nil)
     (lsp-ui-doc-use-webkit        . t)
     ;; (lsp-ui-flycheck-enable       . nil)
     (lsp-ui-peek-enable           . t)
     (lsp-ui-peek-fontify          . 'on-demand) ;; never, on-demand, or always
     (lsp-ui-imenu-enable          . nil)
     (lsp-ui-imenu-kind-position   . 'top)
     (lsp-ui-sideline-enable       . nil)
     (lsp-typescript-format-enable . nil)
     (lsp-typescript-format-insert-space-after-semicolon-in-for-statements . nil)
     )
    )
  :hook
  (web-mode-hook . lsp-deferred)
  (go-mode-hook . lsp-deferred)
  (typescript-mode-hook . lsp-deferred)
   ;; (ruby-mode-hook . lsp-deferred)
  ;; (go-mode-hook . lsp-deferred)
  ;; (terraform-mode-hook . lsp-deferred)
)

(leaf eglot
  :ensure t
  :config
  ;; (add-to-list 'eglot-server-programs
  ;;            `(terraform-mode . ("terraform-ls" "serve" "--port" :autoport)))
  :hook
  ;; (ruby-mode-hook . eglot-ensure)
  ;; (go-mode-hook   . eglot-ensure)
  ;; (terraform-mode-hook   . eglot-ensure)
  ;; (web-mode-hook . eglot-ensure)
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

(leaf magit
  :ensure t
  :bind (("C-x m" . magit-status))
  :config
  (with-eval-after-load 'magit
    (setq-default magit-auto-revert-mode nil)
    (setq vc-handled-backends 'nil)
    (eval-after-load "vc"
      '(remove-hook 'find-file-hooks 'vc-find-file-hook))
    ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_markdown-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(leaf markdown-mode
  :ensure t
  :mode ("\\.markdown\\'" "\\.md\\'"
         ("README\\.md\\'" . gfm-mode))
  :config
  (with-eval-after-load 'markdown-mode
    (add-hook 'markdown-mode-hook
              '(lambda nil
                 (electric-indent-local-mode -1)))
    (setq markdown-preview-stylesheets (list "https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/3.0.1/github-markdown.min.css"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_other-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(leaf fzf
  :ensure t)

(leaf highlight-symbol
  :ensure t)

(leaf erlang
  :ensure t)

(leaf nginx-mode
  :ensure t)

(leaf dockerfile-mode
  :ensure t)

(leaf toml-mode
  :ensure t)

(leaf yaml-mode
  :ensure t)

(leaf highlight-indent-guides
  :ensure t
  ;; :hook
  ;; (yaml-mode-hook . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-auto-enabled . t)
  (highlight-indent-guides-responsive . t)
  (highlight-indent-guides-method . 'character)
  )

(leaf volatile-highlights
  :ensure t
  :require t
  :config
  (volatile-highlights-mode)
  (with-no-warnings
    (when (fboundp 'pulse-momentary-highlight-region)
      (defun my-vhl-pulse (beg end &optional _buf face)
        "Pulse the changes."
        (pulse-momentary-highlight-region beg end face))
      (advice-add #'vhl/.make-hl :override #'my-vhl-pulse)))
  )

(leaf git-gutter+
  :if (>= emacs-major-version 25)
  :ensure t
  :blackout `((git-gutter+-mode
               . ,(format "%s" (all-the-icons-octicon "git-merge"))))
  :bind ("C-x G" . global-git-gutter+-mode)
  )

(leaf ansible
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_protobuf-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(leaf protobuf-mode
  :ensure t
  :mode ("\\.proto\\'")
  :config
  (add-hook 'protobuf-mode-hook
            '(lambda nil
               (company-mode t)
               (dumb-jump-mode t)
               (yas-minor-mode t)
               (setq tab-width 2)
               ))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_ruby-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(leaf ruby-mode
  :ensure t
  :require t
  :preface
  (defun ruby-beautify-buffer nil
    (interactive)
    (let (p
          rb)
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
  :setq ((lsp-diagnostic-package . :none))
  :hook
  ((ruby-mode-hook . company-mode)
   (ruby-mode-hook . dumb-jump-mode)
   (ruby-mode-hook . ruby-end-mode)
   (ruby-mode-hook . yas-minor-mode)
   (ruby-mode-hook . rainbow-delimiters-mode)
   )
  :config
)

(leaf rspec-mode
  :ensure t
  :require t
  )

(leaf rubocop
  :ensure t
  :require t
  :custom
  ((rubocop-prefer-system-executable . t))
  :hook
  ((ruby-mode-hook . rubocop-mode))
  )

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

(leaf ruby-end
  :ensure t
  :require t
  )
(leaf slim-mode
  :mode ("\\.slim$"
         "\\.slime$")
  :ensure t)
(leaf haml-mode
  :ensure t
  :require t
  )
(leaf ruby-hash-syntax
  :ensure t
  :require t
  )
(leaf ruby-refactor
  :ensure t
  :require t
  )

;; (leaf rvm
;;   :ensure t
;;   :if (eq system-type 'darwin)
;;   :commands rvm-use-default
;;   :config
;;   (rvm-use-default)
;;   )

(leaf rbenv
  :ensure t
  :require t
  ;; :if (eq system-type 'gnu/linux)
  :config
  (global-rbenv-mode)
  :custom (
           (rbenv-installation-dir . "~/.rbenv")
           )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_rust-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(leaf rustic
  :ensure t
  :mode ("\\.rs$")
  :custom (;; debug
           (lsp-print-io          . nil)
           (lsp-trace             . nil)
           (lsp-print-performance . nil)
           ;; general
           ;; (lsp-auto-guess-root      . t)
           ;; (lsp-document-sync-method . 'incremental) ;; always send incremental document
           (lsp-response-timeout     . 5)
           (lsp-prefer-flymake       . 'flymake)
           ;; (lsp-enable-completion-at-point . nil)
           (rustic-format-on-save    . t)
           (rustic-lsp-format        . t)
           (rustic-format-trigger    . nil)
           ;; (rustic-rls-pkg           . 'eglot)
           )
  :hook
  ((rustic-mode-hook . company-mode)
   (rustic-mode-hook . dumb-jump-mode)
   (rustic-mode-hook . yas-minor-mode)
   (rustic-mode-hook . rainbow-delimiters-mode)
   )
  :config
  (with-eval-after-load 'rustic
    (progn
      (bind-key "C-M-n" #'rustic-end-of-defun rustic-mode-map nil)
      (bind-key "C-M-p" #'rustic-beginning-of-defun rustic-mode-map nil))

    ;; (setq rustic-rls-pkg 'eglot)
    ;; (setq rustic-format-on-save nil)
    ;; (setq rustic-lsp-format nil)
    ;; (setq rustic-format-trigger nil)
    )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_scss-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(leaf scss-mode
  :ensure t
  :preface
  (defun scss-custom nil
    "scss-mode-hook"
    (and
     (set (make-local-variable 'css-indent-offset) 2)
     (set (make-local-variable 'scss-compile-at-save) nil)
     )
    )

  :mode ("\\.scss$")
  :config
  (with-eval-after-load 'scss-mode
    (add-hook 'scss-mode-hook
              '(lambda nil
                 (scss-custom)))))

(leaf rainbow-mode
  :ensure t
  :require t
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50_terraform-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(leaf terraform-mode
  :ensure t
  :mode ("\\.tf\\'" "\\.hcl\\'")
  :config
  (with-eval-after-load 'terraform-mode
    (add-hook 'terraform-mode-hook
              '(lambda nil
                 (company-mode t)
                 (dumb-jump-mode t)
                 (yas-minor-mode t)
                 (setq tab-width 2)
                 (terraform-format-on-save-mode t)))))

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

(leaf typescript-mode
  :ensure t
  :require t
  )

(leaf web-mode
  :ensure t
  :require t
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
         )
  :custom
  (
   (auto-save-default . nil)
   (web-mode-markup-indent-offset . 2)
   (web-mode-css-indent-offset . 2)
   (web-mode-code-indent-offset . 2)
   (web-mode-attr-indent-offset . 2)
   (web-mode-enable-auto-pairing . t)
   (web-mode-enable-auto-closing . t)
   )
  :hook
  (
   (web-mode-hook . company-mode)
   (web-mode-hook . dumb-jump-mode)
   (web-mode-hook . yas-minor-mode)
   )
  :config
  (setq-default indent-tabs-mode nil)
  ;; (setq-default web-mode-comment-formats (remove '("javascript" . "/*") web-mode-comment-formats))
  (add-to-list 'web-mode-comment-formats '("javascript" . "//"))
  (add-to-list 'web-mode-comment-formats '("jsx" . "//" ))
  (add-to-list 'web-mode-comment-formats '("tsx" . "//" ))
  (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-ternary" . nil))

  (leaf nvm
    :ensure t
    :require t
    :config
    (nvm-use "16.13.0")
    )

  (leaf add-node-modules-path
    :ensure t
    :after nvm
    :require t
    :hook
    (
     (web-mode-hook . add-node-modules-path)
     )
    )

  (leaf prettier
    :ensure t
    :after nvm add-node-modules-path
    :require t
    :hook
    (
     (web-mode-hook . prettier-mode)
     )
    )

  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(leaf ace-jump-mode
  :ensure t
  :require t
  )
(leaf ace-window
  :ensure t
  :require t
  :bind (
         ("C-x a" . ace-window)
         )
  :custom
  (aw-keys . '(?a ?b ?k ?l ?g ?h ?j ?k))
  )

(leaf projectile
  :ensure t
  :require t
  :custom
  (projectile-mode . +1)
  )

(leaf ddskk
  :ensure t
  :bind
  (("C-x C-j" . skk-mode)
   ("C-x j"   . skk-mode))
  :init
  (defvar dired-bind-jump nil)  ; dired-xがC-xC-jを奪うので対処しておく
  :custom
  (skk-use-azik                     . nil)      ; AZIKを使用する
  (skk-azik-keyboard-type           . 'jp106)
  (skk-tut-file                     . nil)
  (skk-server-host                  . "localhost")
  (skk-server-portnum               . 1178)   ;
  (skk-egg-like-newline             . t)      ; 変換時にリターンでは改行しない
  (skk-japanese-message-and-error   . t)      ; メッセージを日本語にする
  (skk-auto-insert-paren            . t)      ; 対応する括弧を自動挿入
  (skk-check-okurigana-on-touroku   . t)      ;
  (skk-show-annotation              . t)      ; アノテーションを表示
  (skk-anotation-show-wikipedia-url . t)      ;
  (skk-show-tooltip                 . nil)    ; 変換候補をインライン表示しない
  (skk-isearch-start-mode           . 'latin) ; isearch時にSKKをオフ
  (skk-henkan-okuri-strictly        . nil)    ; 送り仮名を考慮した変換候補
  (skk-process-okuri-early          . nil)
  (skk-status-indicator             . 'minor-mode)
  :hook
  (skk-azik-load-hook . my/skk-azik-disable-tU)
  :preface
  (defun my/skk-azik-disable-tU ()
    "ddskkのazikモードが`tU'を`っ'として扱うのを抑制する."
    (setq skk-rule-tree (skk-compile-rule-list
                         skk-rom-kana-base-rule-list
                         (skk-del-alist "tU" skk-rom-kana-rule-list)))))
(leaf csv-mode
  :ensure t
  :require t
  :bind
  :init
  :custom
  :hook
  :preface
  )


(leaf atomic-chrome
  :ensure t
  :require t
  :bind
  :init
  (atomic-chrome-start-server)
  )

(leaf tree-sittter
  ;; :hook
  ;; (tree-sitter-after-on-hook . tree-sitter-hl-mode)
  ;; :config
  ;; (global-tree-sitter-mode)
  ;; (tree-sitter-require 'tsx)
  :custom
  (treesit-extra-load-path . '("~/.emacs.d/tree-sitter/"))
  )

;; (leaf tree-sitter-langs
;;   :ensure t
;;   :after tree-sitter
;;   :config
;;   )

;; (leaf treesit-auto
;;   :ensure t
;;   :config
;;   (setq treesit-auto-install t)
;;   (global-treesit-auto-mode)
;;   )
