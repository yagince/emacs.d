(leaf lsp-mode
  :ensure t
  :require t
  :config
  :hook
  (web-mode-hook . lsp-deferred)
)