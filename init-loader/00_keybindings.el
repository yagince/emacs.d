(global-unset-key (kbd "M-SPC"))
(global-set-key "\C-h" 'backward-delete-char)
(define-key global-map [?¥] [?\\])
(define-key global-map (kbd "C-z") nil)

(leaf bind-key
  :ensure t)

(leaf goto-chg
  :ensure t
  :bind (("<f8>" . goto-last-change)
         ("M-<f8>" . goto-last-change-reverse)))
;; (use-package goto-chg
;;   :commands(goto-last-change
;;             goto-last-change-reverse
;;             )
;;   :bind (("<f8>" . goto-last-change)
;;          ("M-<f8>" . goto-last-change-reverse))
;;   :config
;;   ;; any settings...
;;   )

;; Mozc
(leaf mozc
  :ensure t
  :bind (("M-SPC" . toggle-input-method))
  :setq ((default-input-method . "japanese-mozc"))
  :config
  (set-language-environment "Japanese")
  (prefer-coding-system 'utf-8))
;; (use-package mozc
;;   :ensure t
;;   :bind (
;;          ("M-SPC" . toggle-input-method)
;;          )
;;   :init
;;   (set-language-environment "Japanese")
;;   (setq default-input-method "japanese-mozc")
;;   (prefer-coding-system 'utf-8)
;;   :config
;;   )
