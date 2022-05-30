;; (global-unset-key (kbd "M-SPC"))
;; (global-set-key "\C-h" 'backward-delete-char)
;; (define-key global-map [?¥] [?\\])
;; (define-key global-map (kbd "C-z") nil)

;; (leaf bind-key
;;   :ensure t)

;; (leaf goto-chg
;;   :ensure t
;;   :bind (("<f8>" . goto-last-change)
;;          ("M-<f8>" . goto-last-change-reverse)))
;; ;; (use-package goto-chg
;; ;;   :commands(goto-last-change
;; ;;             goto-last-change-reverse
;; ;;             )
;; ;;   :bind (("<f8>" . goto-last-change)
;; ;;          ("M-<f8>" . goto-last-change-reverse))
;; ;;   :config
;; ;;   ;; any settings...
;; ;;   )

;; ;; Mozc
;; ;; (leaf mozc
;; ;;   :ensure t
;; ;;   :if (eq system-type 'gnu/linux)
;; ;;   :bind (("M-SPC" . toggle-input-method))
;; ;;   :setq ((default-input-method . "japanese-mozc"))
;; ;;   :config
;; ;;   (set-language-environment "Japanese")
;; ;;   (prefer-coding-system 'utf-8))
;; ;; (use-package mozc
;; ;;   :ensure t
;; ;;   :bind (
;; ;;          ("M-SPC" . toggle-input-method)
;; ;;          )
;; ;;   :init
;; ;;   (set-language-environment "Japanese")
;; ;;   (setq default-input-method "japanese-mozc")
;; ;;   (prefer-coding-system 'utf-8)
;; ;;   :config
;; ;;   )

;; (leaf mozc
;;   :ensure t
;;   :if (eq system-type 'gnu/linux)
;;   :bind* ("M-SPC" . toggle-input-method)
;;   :config
;;   (setq default-input-method "japanese-mozc"
;;         mozc-helper-program-name "mozc_emacs_helper"
;;         mozc-leim-title "Mozc"
;;         )
;;   :preface
;;   (defadvice toggle-input-method (around toggle-input-method-around activate)
;;     "Input method function in key-chord.el not to be nil."
;;     (let ((input-method-function-save input-method-function))
;;       ad-do-it
;;       (setq input-method-function input-method-function-save)))
;;   (defun mozc-insert-str (str)
;;     "If punctuation marks, immediately confirm."
;;     (mozc-handle-event 'enter)
;;     (toggle-input-method)
;;     (insert str)
;;     (toggle-input-method))
;;   (add-hook 'mozc-mode-hook
;;             (lambda ()
;;               (define-key mozc-mode-map "?" '(lambda () (interactive) (mozc-insert-str "？")))
;;               (define-key mozc-mode-map "," '(lambda () (interactive) (mozc-insert-str "、")))
;;               (define-key mozc-mode-map "." '(lambda () (interactive) (mozc-insert-str "。")))))
;;   :init
;;   ;; (leaf mozc-temp
;;   ;;   :ensure t
;;   ;;   :bind* ("C-M-n" . mozc-temp-convert))
;;   (leaf mozc-cursor-color
;;     :el-get iRi-E/mozc-el-extensions
;;     :require t
;;     :config
;;     (setq mozc-cursor-color-alist
;;           '((direct . "#BD93F9")
;;             (read-only . "#84A0C6")
;;             (hiragana . "#CC3333"))))
;;   (leaf mozc-cand-posframe
;;     :ensure t
;;     :require t
;;     :config
;;     (setq mozc-candidate-style 'posframe)
;;     :init
;;     (leaf posframe :ensure t)))


;; (leaf *user-mozc-tool
;;   :if (eq system-type 'gnu/linux)
;;   :init
;;   (defun my:select-mozc-tool ()
;;     "Narrow the only espy command in M-x."
;;     (interactive)
;;     (counsel-M-x "^my:mozc "))

;;   (defun my:mozc-config-dialog ()
;;     "Run the mozc-tool in the background."
;;     (interactive)
;;     (compile "/usr/lib/mozc/mozc_tool --mode=config_dialog")
;;     (delete-other-windows))

;;   (defun my:mozc-dictionary-tool ()
;;     "Run the mozc-tool in the background."
;;     (interactive)
;;     (compile "/usr/lib/mozc/mozc_tool --mode=dictionary_tool")
;;     (delete-other-windows))

;;   (defun my:mozc-word-regist ()
;;     "Run the mozc-tool in the background."
;;     (interactive)
;;     (compile "/usr/lib/mozc/mozc_tool --mode=word_register_dialog")
;;     (delete-other-windows))

;;   (defun my:mozc-hand-writing ()
;;     "Run the mozc-tool in the background."
;;     (interactive)
;;     (compile "/usr/lib/mozc/mozc_tool --mode=hand_writing")
;;     (delete-other-windows)))
