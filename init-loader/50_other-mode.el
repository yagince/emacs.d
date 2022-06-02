;;  (leaf fzf
;;   :ensure t)

;; (leaf highlight-symbol
;;   :ensure t)

;; (leaf erlang
;;   :ensure t)

;; (leaf nginx-mode
;;   :ensure t)

;; (leaf dockerfile-mode
;;   :ensure t)

;; (leaf toml-mode
;;   :ensure t)

;; (leaf yaml-mode
;;   :ensure t)

;; (leaf highlight-indent-guides
;;   :ensure t
;;   :hook
;;   (yaml-mode . highlight-indent-guides-mode)
;;   :custom
;;   (highlight-indent-guides-auto-enabled . t)
;;   (highlight-indent-guides-responsive . t)
;;   (highlight-indent-guides-method . 'character)
;;   )

;; (leaf volatile-highlights
;;   :ensure t
;;   :config
;;   (volatile-highlights-mode)
;;   (with-no-warnings
;;     (when (fboundp 'pulse-momentary-highlight-region)
;;       (defun my-vhl-pulse (beg end &optional _buf face)
;;         "Pulse the changes."
;;         (pulse-momentary-highlight-region beg end face))
;;       (advice-add #'vhl/.make-hl :override #'my-vhl-pulse)))
;;   )

;; (leaf git-gutter+
;;   :if (>= emacs-major-version 25)
;;   :ensure t
;;   :blackout `((git-gutter+-mode
;;                . ,(format "%s" (all-the-icons-octicon "git-merge"))))
;;   :bind ("C-x G" . global-git-gutter+-mode)
;;   )

;; (leaf ansible
;;   :ensure t)
