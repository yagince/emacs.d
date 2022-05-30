;; ;; (use-package neotree
;; ;;   :bind (
;; ;;          ("C-x n" . neotree-show)
;; ;;          )
;; ;;   :init
;; ;;   :config
;; ;;   ;; 隠しファイルをデフォルトで表示
;; ;;   (setq neo-show-hidden-files t)
;; ;;   (setq neo-keymap-style 'concise)
;; ;;   (setq neo-smart-open t)
;; ;;   (setq neo-create-file-auto-open t)
;; ;;   (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
;; ;;   )

;; (leaf neotree
;;   :ensure t
;;   :bind (("C-x n" . neotree-show))
;;   :config
;;   (with-eval-after-load 'neotree
;;     (setq neo-show-hidden-files t) ;; 隠しファイルをデフォルトで表示
;;     (setq neo-keymap-style 'concise)
;;     (setq neo-smart-open t)
;;     (setq neo-create-file-auto-open t)
;;     (setq neo-theme (if (display-graphic-p)
;;                         'icons 'arrow)))
;;   :custom
;;   ;; ((neo-window-fixed-size . nil))
;;   ((projectile-switch-project-action . 'neotree-projectile-action))
;;   )
