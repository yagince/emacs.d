;; go
(eval-after-load "go-mode"
  '(require 'flymake-go))

(add-to-list 'load-path "~/go/src/github.com/nsf/gocode/emacs")
(require 'go-autocomplete)
(require 'auto-complete-config)

(add-hook 'before-save-hook 'gofmt-before-save)

(add-hook 'go-mode-hook '(lambda ()
                           (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))

(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "M-.") 'godef-jump)))

(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "C-c C-i") 'go-import-add)))
