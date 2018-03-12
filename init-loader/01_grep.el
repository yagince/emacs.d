; ag
(require 'ag)
(setq ag-highlight-search t)  ; 検索キーワードをハイライト
(setq ag-reuse-buffers t)     ; 検索用バッファを使い回す (検索ごとに新バッファを作らない)

; wgrep
(require 'wgrep)
(add-hook 'ag-mode-hook '(lambda ()
                           (require 'wgrep-ag)
                           (setq wgrep-auto-save-buffer t)  ; 編集完了と同時に保存
                           (setq wgrep-enable-key "r")      ; "r" キーで編集モードに
                           (wgrep-ag-setup)))
; ripgrep
(require 'ripgrep)
;;; rgに渡すオプション
(setq ripgrep-arguments '("-i"))
; rg
(require 'rg)
(rg-enable-default-bindings (kbd "M-s"))
(add-hook 'rg-mode-hook 'wgrep-ag-setup)
