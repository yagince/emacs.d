; 極力UTF-8とする
(prefer-coding-system 'utf-8)

(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

(setq backup-inhibited t)
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
