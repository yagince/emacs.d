; 極力UTF-8とする
(prefer-coding-system 'utf-8)

(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

(setq backup-inhibited t)
(setq make-backup-files nil)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq transient-mark-mode t)

;; disabled auto-save
(setq auto-save-mode nil)
(setq buffer-auto-save-file-name nil)

(setq exec-path (cons "/usr/local/bin" exec-path))

;; emacs --no-splash
;; M-x display-splash-screen で表示。
(setq inhibit-startup-message t)

(global-set-key "\C-h" 'backward-delete-char)
(define-key global-map [?¥] [?\\])  ;;

;; デフォルトのインデント
(setq-default indent-line-function 'tab-to-tab-stop)
(setq-default tab-width 2)
(setq-default tab-stop-list '(2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60
                                62 64 66 68 70 72 74 76 78 80 82 84 86 88 90 92 94 96 98 100 102 104 106 108 110 112 114 116 118 120))
(setq-default indent-tabs-mode nil)

;; load-path
(add-to-list 'load-path "~/.emacs.d/elisp")

;; 矩形モード
(cua-mode t)
(setq cua-enable-cua-keys nil) 

;; theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;;(load-theme 'pastels-on-dark t)
(setq initial-frame-alist
      (append (list '(foreground-color . "white")
                    '(background-color . "black")
                    '(border-color . "gray")
                    '(mouse-color . "white")
                    '(cursor-color . "lightblue")
                    '(alpha . (80 70))
                    '(width . 150)
                    '(height . 45)
                    '(top . 100)
                    '(left . 100))
              default-frame-alist))

;; package
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; linum
(global-linum-mode t)
(setq linum-format "%4d ")

;; この中でconfigとanything本体をrequireしている
(require 'anything)
(define-key global-map (kbd "C-;") 'anything)

;; scala-mode
(require 'scala-mode2)

;; バッファきりかえ
(iswitchb-mode 1)
(setq read-buffer-function 'iswitchb-read-buffer)
(setq iswitchb-regex nil)
(setq iswitch-prompt-newbuffer nil)

;; redo+
(require 'redo+)
(global-set-key (kbd "C-M-/") 'redo)
(setq undo-limit 600000)
(setq undo-strong-limit 900000)

;; ruby-mode
;; Rake files are ruby, too, as are gemspecs, rackup files, and gemfiles.
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.jbuilder$" . ruby-mode))

;; rhmtl
(add-to-list 'load-path "~/.emacs.d/elisp/rhtml")
(require 'rhtml-mode)
(defun rhtml-mode-hook ()
  (autoload 'rhtml-mode "rhtml-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . rhtml-mode))
  (add-to-list 'auto-mode-alist '("\\.rjs\\'" . rhtml-mode)))

;; scratch-log
(require 'scratch-log)

;; TypeScript
(add-to-list 'load-path "~/.emacs.d/elisp/typeScript")
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
(autoload 'typescript-mode "TypeScript" "Major mode for editing typescript." t)

;; auto-complete
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-20130209.651/dict")
(require 'auto-complete-config)
(ac-config-default)
(add-hook 'auto-complete-mode-hook
	  (lambda()
	    (define-key ac-completing-map (kbd "C-n") 'ac-next)
	    (define-key ac-completing-map (kbd "C-p") 'ac-previous)))

;; markdown-mode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; cperl-mode
(defalias 'perl-mode 'cperl-mode)
(setq auto-mode-alist
    (append '(("\\.\\([pP][Llm]\\|al\\)$" . cperl-mode)) auto-mode-alist ))
(add-hook 'cperl-mode-hook
    '(lambda()
        (setq indent-tabs-mode nil)
        (setq cperl-tab-always-indent t)
        (setq cperl-indent-parens-as-block t)
        (setq cperl-close-paren-offset -4)
        (setq cperl-continued-statement-offset 4)
        (setq cperl-indent-level 4)
        ))
;; (setq auto-mode-alist (cons '("\\.t$" . cperl-mode) auto-mode-alist))
;; '(cperl-close-paren-offset -4)
;; '(cperl-continued-statement-offset 4)
;; '(cperl-indent-level 4)
;; '(cperl-indent-parens-as-block t)
;; '(cperl-tab-always-indent t)

;; perlbrew
(require 'perlbrew)
(perlbrew-use "perl-5.19.0")

;; quickrun
(global-set-key "\C-q" 'quickrun)
