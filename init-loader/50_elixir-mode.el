;; (use-package elixir-mode
;;   :mode (
;;          ("\\.elixir2\\'" . elixir-mode)
;;          ("\\.ex$" . elixir-mode)
;;          ("\\.exs$" . elixir-mode)
;;          )
;;   :init
;;   (yas-reload-all)
;;   (add-hook 'elixir-mode-hook
;;             '(lambda ()
;;                (company-mode t)
;;                (dumb-jump-mode t)
;;                (yas-minor-mode t)
;;                ))
;;   :config
;;   (add-to-list 'elixir-mode-hook
;;                (defun auto-activate-ruby-end-mode-for-elixir-mode ()
;;                  (set (make-variable-buffer-local 'ruby-end-expand-keywords-before-re)
;;                       "\\(?:^\\|\\s-+\\)\\(?:do\\)")
;;                  (set (make-variable-buffer-local 'ruby-end-check-statement-modifiers) nil)
;;                  (ruby-end-mode +1)))
;;   )
(leaf elixir-mode
  :ensure t
  :mode ("\\.elixir2\\'" "\\.ex$" "\\.exs$")
  :config
  (yas-reload-all)
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
