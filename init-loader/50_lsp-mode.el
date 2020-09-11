(leaf lsp-mode
  :ensure t
  :config
  :hook
  (web-mode-hook . lsp-deferred)
  (ruby-mode-hook . lsp-deferred)
)
