(use-package ruby-mode
  :bind (
         ("C-c C-v f" . ruby-beautify-buffer)
         ("C-M-n" . ruby-end-of-block)
         ("C-M-p" . ruby-beginning-of-block)
         )
  :mode (
         ("\\.rb$" . ruby-mode)
         ("\\.jb$" . ruby-mode)
         ("\\.ruby$" . ruby-mode)
         ("\\.rake$" . ruby-mode)
         ("Rakefile$" . ruby-mode)
         ("\\.gemspec$" . ruby-mode)
         ("\\.ru$" . ruby-mode)
         ("Gemfile$" . ruby-mode)
         ("Guardfile$" . ruby-mode)
         ("\\.jbuilder$" . ruby-mode)
         ("Schemafile$" . ruby-mode)
         )
  :init
  (global-rbenv-mode)
  (rvm-use-default)
  (setq lsp-diagnostic-package :none)
  (defun ruby-beautify-buffer ()
    (interactive)
    (let (p rb)
      (setq p (point) rb (buffer-string))

      (with-temp-buffer
        (insert rb)
        (call-process-region (point-min) (point-max) "rbeautify" t t)
        (setq rb (buffer-string)))

      (erase-buffer)
      (insert rb)
      (goto-char p)))
  (add-hook 'ruby-mode-hook
            '(lambda ()
               (company-mode t)
               (dumb-jump-mode t)
               (yas-minor-mode t)
               ))

  :config
  (rvm-use-default)
  (yas-reload-all)
  (setq ruby-insert-encoding-magic-comment nil)
  (setq ruby-deep-indent-paren-style nil)
  (setq ruby-deep-indent-paren-style nil)

  (defadvice ruby-indent-line (after unindent-closing-paren activate)
    (let ((column (current-column))
          indent offset)
      (save-excursion
        (back-to-indentation)
        (let ((state (syntax-ppss)))
          (setq offset (- column (current-column)))
          (when (and (eq (char-after) ?\))
                     (not (zerop (car state))))
            (goto-char (cadr state))
            (setq indent (current-indentation)))))
      (when indent
        (indent-line-to indent)
        (when (> offset 0) (forward-char offset)))))

  (use-package quickrun
    :defer t
    :ensure t)
  (use-package lsp-mode
    :defer t
    :init
    (add-hook 'ruby-mode-hook #'lsp)
    )
  )

(use-package rvm
  :defer t
  :commands (rvm-use-default)
  )

(use-package dumb-jump
  :defer t
  :bind (
         ("C-M-g" . dumb-jump-go)
         ("C-M-b" . dumb-jump-back)
         ("C-M-q" . dumb-jump-quick-look)
         )
  :config
  (setq dumb-jump-selector 'ivy)
  (bind-keys :map dumb-jump-mode-map
             ("C-M-p" . nil)
             )
  )
