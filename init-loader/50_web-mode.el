;; web-mode
(require 'web-mode)
;; 拡張子の設定
(add-to-list 'auto-mode-alist '("\\.phtml$"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x$"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?$"     . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.vue?$"      . web-mode))
(add-to-list 'auto-mode-alist '("\\.js?$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?$"      . web-mode))
;; インデント関係
(defun web-mode-setting-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset  2)
  (setq web-mode-css-indent-offset     2)
  (setq web-mode-code-indent-offset    2)
  (setq indent-tabs-mode               nil)
  )

(add-hook 'web-mode-hook 'web-mode-setting-hook)
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
