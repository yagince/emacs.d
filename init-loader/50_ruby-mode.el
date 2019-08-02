;; ruby-mode
;; Rake files are ruby, too, as are gemspecs, rackup files, and gemfiles.
;; (defun ruby-mode-set-encoding () nil)
;; (setq ruby-insert-encoding-magic-comment nil)
;; (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("\\.ruby$" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("Guardfile$" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("\\.jbuilder$" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("Schemafile$" . ruby-mode))

;; ;; ruby-modeのインデントを改良する
;; (setq ruby-deep-indent-paren-style nil)
;; (defadvice ruby-indent-line (after unindent-closing-paren activate)
;;   (let ((column (current-column))
;;         indent offset)
;;     (save-excursion
;;       (back-to-indentation)
;;       (let ((state (syntax-ppss)))
;;         (setq offset (- column (current-column)))
;;         (when (and (eq (char-after) ?\))
;;                    (not (zerop (car state))))
;;           (goto-char (cadr state))
;;           (setq indent (current-indentation)))))
;;     (when indent
;;       (indent-line-to indent)
;;       (when (> offset 0) (forward-char offset)))))

;; ;; rvm
;; (require 'rvm)
;; (rvm-use-default)

;; ;; robe
;; ;; (autoload 'robe-mode "robe" "Code navigation, documentation lookup and completion for Ruby" t nil)
;;  ;; (autoload 'robe-ac-setup "robe-ac" "robe auto-complete" nil nil)
;; ;; (add-hook 'robe-mode-hook 'robe-ac-setup)

;; ;; (add-hook 'ruby-mode-hook 'robe-mode)
;; (require 'eglot)
;; (add-hook 'ruby-mode-hook 'eglot-ensure)

;; ;; ;; rubocop
;; ;; (require 'rubocop)
;; ;; (add-hook 'ruby-mode-hook 'rubocop-mode)

;; ;; rbeautify
;; ;; required) gem install rbeautify
;; (defun ruby-beautify-buffer ()
;;   (interactive)
;;   (let (p rb)
;;       (setq p (point) rb (buffer-string))

;;       (with-temp-buffer
;;         (insert rb)
;;         (call-process-region (point-min) (point-max) "rbeautify" t t)
;;         (setq rb (buffer-string)))

;;       (erase-buffer)
;;       (insert rb)
;;       (goto-char p)))

;; (eval-after-load 'ruby-mode
;;   '(define-key ruby-mode-map (kbd "C-c C-v f") 'ruby-beautify-buffer))

;; ;; refactor-mode
;; (add-hook 'ruby-mode-hook 'ruby-refactor-mode-launch)

;; (require 'dumb-jump)
;; (add-hook 'ruby-mode-hook 'dumb-jump-mode)
;; (add-hook 'dumb-jump-mode-hook
;;           '(lambda ()
;;              (define-key dumb-jump-mode-map (kbd "C-M-p") nil)
;;              (define-key dumb-jump-mode-map (kbd "C-M-g") 'dumb-jump-go)
;;              (define-key dumb-jump-mode-map (kbd "C-M-b") 'dumb-jump-back)
;;              (define-key dumb-jump-mode-map (kbd "C-M-q") 'dumb-jump-quick-look)
;;              ))


;; ;; key-bindings
;; (add-hook 'ruby-mode-hook
;;           '(lambda ()
;;              (define-key ruby-mode-map (kbd "C-M-n") 'ruby-end-of-block)
;;              (define-key ruby-mode-map (kbd "C-M-p") 'ruby-beginning-of-block)
;;              ))

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
  (use-package eglot
    :defer t
    :init
    (add-hook 'ruby-mode-hook 'eglot-ensure)
    )
  )

(use-package rvm
  :defer t
  :commands (rvm-use-default)
  )

(use-package dumb-jump
  :defer t
  :commands (dumb-jump-mode dumb-jump-go dumb-jump-back dumb-jump-quick-look)
  :config
  (bind-keys :map dumb-jump-mode-map
             ("C-M-g" . dumb-jump-go)
             ("C-M-b" . dumb-jump-back)
             ("C-M-q" . dumb-jump-quick-look)
             )
  )
