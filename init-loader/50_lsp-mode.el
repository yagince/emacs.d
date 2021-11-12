(leaf lsp-mode
  :ensure t
  ;; :custom
  ;; (
  ;;  (lsp-eslint-auto-fix-on-save . t)
  ;;  )
  :config
  (leaf lsp-ui
    :ensure t
    :custom
    (
     ;; (lsp-ui-doc-enable            . nil)
     (lsp-ui-doc-header            . t)
     (lsp-ui-doc-include-signature . t)
     (lsp-ui-doc-position          . 'at-point)
     (lsp-ui-doc-max-width         . 150)
     (lsp-ui-doc-max-height        . 30)
     (lsp-ui-doc-use-childframe    . nil)
     (lsp-ui-doc-use-webkit        . t)
     ;; (lsp-ui-flycheck-enable       . nil)
     (lsp-ui-peek-enable           . t)
     (lsp-ui-peek-peek-height      . 20)
     (lsp-ui-peek-list-width       . 50)
     (lsp-ui-peek-fontify          . 'on-demand) ;; never, on-demand, or always
     (lsp-ui-imenu-enable          . nil)
     (lsp-ui-imenu-kind-position   . 'top)
     (lsp-ui-sideline-enable       . nil)
     )
    )
  :hook
  (web-mode-hook . lsp-deferred)
  ;; (ruby-mode-hook . lsp-deferred)
  ;; (go-mode-hook . lsp-deferred)
  ;; (terraform-mode-hook . lsp-deferred)
)

(leaf eglot
  :ensure t
  :config
  (add-to-list 'eglot-server-programs
             `(terraform-mode . ("terraform-ls" "serve" "--port" :autoport)))
  :hook
  (ruby-mode-hook . eglot-ensure)
  (go-mode-hook   . eglot-ensure)
  ;; (terraform-mode-hook   . eglot-ensure)
  )
