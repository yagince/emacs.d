(use-package scss-mode
  :mode (("\\.scss$" . scss-mode))
  :init
  (defun scss-custom ()
    "scss-mode-hook"
    (and
     (set (make-local-variable 'css-indent-offset) 2) ;; インデント幅を2にする
     (set (make-local-variable 'scss-compile-at-save) nil) ;; コンパイルは compass watchで行うので自動コンパイルをオフ
     )
    )
  :config
  (add-hook 'scss-mode-hook
            '(lambda() (scss-custom)))
  )
