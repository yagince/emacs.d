;; (use-package scss-mode
;;   :mode (("\\.scss$" . scss-mode))
;;   :init
;;   (defun scss-custom ()
;;     "scss-mode-hook"
;;     (and
;;      (set (make-local-variable 'css-indent-offset) 2) ;; インデント幅を2にする
;;      (set (make-local-variable 'scss-compile-at-save) nil) ;; コンパイルは compass watchで行うので自動コンパイルをオフ
;;      )
;;     )
;;   :config
;;   (add-hook 'scss-mode-hook
;;             '(lambda() (scss-custom)))
;;   )
(leaf scss-mode
  :ensure t
  :preface
  (defun scss-custom nil
    "scss-mode-hook"
    (and
     (set (make-local-variable 'css-indent-offset) 2)
     (set (make-local-variable 'scss-compile-at-save) nil)
     )
    )

  :mode ("\\.scss$")
  :config
  (with-eval-after-load 'scss-mode
    (add-hook 'scss-mode-hook
              '(lambda nil
                 (scss-custom)))))

(leaf rainbow-mode
  :ensure t
  :require t
  )
