;; <leaf-install-code>
(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))
;; </leaf-install-code>
(setq gc-cons-threshold (* 128 1024 1024))

(leaf leaf
  :config
  (leaf leaf-convert :ensure t)
  (leaf leaf-tree
    :ensure t
    :custom ((imenu-list-size . 30)
             (imenu-list-position . 'left))))

(leaf macrostep
  :ensure t
  :bind (("C-c e" . macrostep-expand)))

(leaf exec-path-from-shell
  :ensure t
  :defun (exec-path-from-shell-initialize)
  :custom
  ((exec-path-from-shell-variables           . '("RUST_SRC_PATH"
                                                 "PATH")))
  :config
  (exec-path-from-shell-initialize)
  )

(leaf init-loader
  :ensure t
  :config
  (init-loader-load "~/.emacs.d/init-loader")
  )
