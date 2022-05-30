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
(setq ring-bell-function 'ignore)

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
                                                 "GOPATH"
                                                 "PATH")))
  :config
  (exec-path-from-shell-initialize)
  )

(leaf init-loader
  :ensure t
  :config
  (init-loader-load "~/.emacs.d/init-loader")
  )

(leaf ace
  :config
  (leaf ace-jump-mode
    :ensure t
    )
  (leaf ace-window
    :ensure t
    :bind (
           ("C-x a" . ace-window)
           )
    :custom
    (aw-keys . '(?a ?b ?k ?l ?g ?h ?j ?k))
    )
  )

(leaf projectile
  :ensure t
  :custom
  ((projectile-mode . +1))
  )

(leaf ddskk
  :ensure t
  :bind
  (("C-x C-j" . skk-mode)
   ("C-x j"   . skk-mode))
  :init
  (defvar dired-bind-jump nil)  ; dired-xがC-xC-jを奪うので対処しておく
  :custom
  (skk-use-azik                     . nil)      ; AZIKを使用する
  (skk-azik-keyboard-type           . 'jp106)
  (skk-tut-file                     . nil)
  (skk-server-host                  . "localhost")
  (skk-server-portnum               . 1178)   ;
  (skk-egg-like-newline             . t)      ; 変換時にリターンでは改行しない
  (skk-japanese-message-and-error   . t)      ; メッセージを日本語にする
  (skk-auto-insert-paren            . t)      ; 対応する括弧を自動挿入
  (skk-check-okurigana-on-touroku   . t)      ;
  (skk-show-annotation              . t)      ; アノテーションを表示
  (skk-anotation-show-wikipedia-url . t)      ;
  (skk-show-tooltip                 . nil)    ; 変換候補をインライン表示しない
  (skk-isearch-start-mode           . 'latin) ; isearch時にSKKをオフ
  (skk-henkan-okuri-strictly        . nil)    ; 送り仮名を考慮した変換候補
  (skk-process-okuri-early          . nil)
  (skk-status-indicator             . 'minor-mode)
  :hook
  (skk-azik-load-hook . my/skk-azik-disable-tU)
  :preface
  (defun my/skk-azik-disable-tU ()
    "ddskkのazikモードが`tU'を`っ'として扱うのを抑制する."
    (setq skk-rule-tree (skk-compile-rule-list
                         skk-rom-kana-base-rule-list
                         (skk-del-alist "tU" skk-rom-kana-rule-list)))))
(leaf csv-mode
  :ensure t
  :bind
  :init
  :custom
  :hook
  :preface
)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(all-the-icons-scale-factor 1.0)
 '(doom-modeline-buffer-file-name-style 'truncate-with-project)
 '(doom-modeline-icon t)
 '(doom-modeline-major-mode-icon nil)
 '(doom-modeline-minor-modes nil)
 '(exec-path-from-shell-variables '("RUST_SRC_PATH" "GOPATH" "PATH"))
 '(imenu-list-position 'left)
 '(imenu-list-size 30)
 '(package-archives
   '(("org" . "https://orgmode.org/elpa/")
     ("melpa" . "https://melpa.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/")))
 '(package-selected-packages
   '(csv-mode ddskk projectile ace-window ace-jump-mode typescript-mode web-mode prettier add-node-modules-path nvm vue-mode terraform-mode rainbow-mode scss-mode rustic rbenv ruby-refactor ruby-hash-syntax haml-mode slim-mode ruby-end rspec-mode ruby-mode protobuf-mode ansible git-gutter+ volatile-highlights highlight-indent-guides yaml-mode toml-mode dockerfile-mode nginx-mode erlang highlight-symbol fzf markdown-mode magit eglot lsp-ui lsp-mode json-mode graphql-mode go-mode elixir-mode csharp-mode company-box company ivy-yasnippet ivy-prescient prescient counsel swiper ivy-hydra ivy-rich all-the-icons-ivy-rich open-junk-file rainbow-delimiters expand-region quickrun flycheck undo-tree yasnippet scratch-log neotree linum ivy smart-jump dumb-jump cyberpunk-theme wgrep rg anzu multiple-cursors goto-chg bind-key doom-modeline all-the-icons init-loader exec-path-from-shell macrostep leaf-tree leaf-convert blackout el-get hydra leaf-keywords leaf)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
