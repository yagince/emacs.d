;; auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(setq ac-use-menu-map t)       ;; 補完メニュー表示時にC-n/C-pで補完候補選択
(setq ac-use-fuzzy t)
(add-to-list 'ac-modes 'text-mode)         ;; text-modeでも自動的に有効にする
(add-to-list 'ac-modes 'elixir-mode)
(add-to-list 'ac-modes 'go-mode)

;; (defun load-auto-complete ()
;;   (require 'auto-complete-config)
;;   (ac-config-default)
;;   (add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-20130209.651/dict")
;;   (setq ac-use-menu-map t)
;;   (define-key ac-menu-map "\C-n" 'ac-next)
;;   (define-key ac-menu-map "\C-p" 'ac-previous)
;;   (setq ac-auto-show-menu 0.5)
;;   (setq ac-menu-height 20)
;;   (robe-mode))
