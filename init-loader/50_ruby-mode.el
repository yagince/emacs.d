(leaf ruby-mode
  :ensure t
  :preface
  (defun ruby-beautify-buffer nil
    (interactive)
    (let (p
          rb)
      (setq p (point)
            rb (buffer-string))
      (with-temp-buffer
        (insert rb)
        (call-process-region
         (point-min)
         (point-max)
         "rbeautify" t t)
        (setq rb (buffer-string)))
      (erase-buffer)
      (insert rb)
      (goto-char p)))

  :bind (("C-c C-v f" . ruby-beautify-buffer)
         ("C-M-n" . ruby-end-of-block)
         ("C-M-p" . ruby-beginning-of-block))
  :mode ("\\.rb$"
         "\\.jb$"
         "\\.ruby$"
         "\\.rake$"
         "Rakefile$"
         "\\.gemspec$"
         "\\.ru$"
         "Gemfile$"
         "Guardfile$"
         "\\.jbuilder$"
         "Schemafile$")
  :setq ((lsp-diagnostic-package . :none))
  :config

  (add-hook 'ruby-mode-hook
            '(lambda nil
               (company-mode t)
               (dumb-jump-mode t)
               (yas-minor-mode t)
               (ruby-end-mode t)
               (rainbow-delimiters-mode t)
               ))
  (with-eval-after-load 'ruby-mode
    (yas-reload-all)
    (setq ruby-insert-encoding-magic-comment nil)
    (setq ruby-deep-indent-paren-style nil)
    (setq ruby-deep-indent-paren-style nil)
    (defadvice ruby-indent-line (after unindent-closing-paren activate)
      (let ((column (current-column))
            indent
            offset)
        (save-excursion
          (back-to-indentation)
          (let ((state (syntax-ppss)))
            (setq offset (- column
                            (current-column)))
            (when (and
                   (eq
                    (char-after)
                    41)
                   (not (zerop
                         (car state))))
              (goto-char (cadr state))
              (setq indent (current-indentation)))))
        (when indent
          (indent-line-to indent)
          (when (> offset 0)
            (forward-char offset)))))))

(leaf ruby-end
  :ensure t)
(leaf slim-mode
  :ensure t)
(leaf haml-mode
  :ensure t)
(leaf ruby-hash-syntax
  :ensure t)
(leaf ruby-refactor
  :ensure t)

(leaf rvm
  :ensure t
  :if (eq system-type 'darwin)
  :commands rvm-use-default
  :config
  (rvm-use-default)
  )

(leaf rbenv
  :ensure t
  :if (eq system-type 'gnu/linux)
  :config
  (global-rbenv-mode)
  :custom (
           (rbenv-installation-dir . "~/.rbenv")
           )
  )

;; (use-package ruby-mode
;;   :bind (
;;          ("C-c C-v f" . ruby-beautify-buffer)
;;          ("C-M-n" . ruby-end-of-block)
;;          ("C-M-p" . ruby-beginning-of-block)
;;          )
;;   :mode (
;;          ("\\.rb$" . ruby-mode)
;;          ("\\.jb$" . ruby-mode)
;;          ("\\.ruby$" . ruby-mode)
;;          ("\\.rake$" . ruby-mode)
;;          ("Rakefile$" . ruby-mode)
;;          ("\\.gemspec$" . ruby-mode)
;;          ("\\.ru$" . ruby-mode)
;;          ("Gemfile$" . ruby-mode)
;;          ("Guardfile$" . ruby-mode)
;;          ("\\.jbuilder$" . ruby-mode)
;;          ("Schemafile$" . ruby-mode)
;;          )
;;   :init
;;   (global-rbenv-mode)
;;   (rvm-use-default)
;;   (setq lsp-diagnostic-package :none)
;;   (defun ruby-beautify-buffer ()
;;     (interactive)
;;     (let (p rb)
;;       (setq p (point) rb (buffer-string))

;;       (with-temp-buffer
;;         (insert rb)
;;         (call-process-region (point-min) (point-max) "rbeautify" t t)
;;         (setq rb (buffer-string)))

;;       (erase-buffer)
;;       (insert rb)
;;       (goto-char p)))
;;   (add-hook 'ruby-mode-hook
;;             '(lambda ()
;;                (company-mode t)
;;                (dumb-jump-mode t)
;;                (yas-minor-mode t)
;;                ))

;;   :config
;;   (rvm-use-default)
;;   (yas-reload-all)
;;   (setq ruby-insert-encoding-magic-comment nil)
;;   (setq ruby-deep-indent-paren-style nil)
;;   (setq ruby-deep-indent-paren-style nil)

;;   (defadvice ruby-indent-line (after unindent-closing-paren activate)
;;     (let ((column (current-column))
;;           indent offset)
;;       (save-excursion
;;         (back-to-indentation)
;;         (let ((state (syntax-ppss)))
;;           (setq offset (- column (current-column)))
;;           (when (and (eq (char-after) ?\))
;;                      (not (zerop (car state))))
;;             (goto-char (cadr state))
;;             (setq indent (current-indentation)))))
;;       (when indent
;;         (indent-line-to indent)
;;         (when (> offset 0) (forward-char offset)))))

;;   )

;; (use-package rvm
;;   :ensure t
;;   :defer t
;;   :commands (rvm-use-default)
;;   )
