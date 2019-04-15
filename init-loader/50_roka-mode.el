;; ----------------------------------------
;; 定数
(defvar roka-mode-constants
  '("$BOS" "$EOS"
    "DUMMY" "DUMMY%"
    "記号" "読点" "句点" "一般" "括弧閉" "括弧開"
    "名詞" "サ変接続" "接頭詞" "数" "アルファベット" "接尾" "固有名詞" "組織" "助数詞" "名詞-固有名詞-製品" "地域"
    "動詞"
    "助詞" "助動詞"
    "形容詞" "副詞" "自立"
    "特殊・タ" "特殊・ダ"
    ))

;; ----------------------------------------
;; 組み込み関数
(defvar roka-mode-keywords
  '("include"))

;; ----------------------------------------
;; tab
;; I'd probably put in a default that you want, as opposed to nil
(defvar roka-mode-tab-width 2 "Width of a tab for ROKA-MODE mode")

;; ----------------------------------------
;; Faces
(defface roka-mode-single-morpheme-face
  '((t (:foreground "#F5DA81")))
  nil)
(defvar roka-mode-single-morpheme-face 'roka-mode-single-morpheme-face)

;; ----------------------------------------
;; Commands

(defun roka-mode-cmd-insert-dummy ()
  "insert DUMMY%"
  (interactive)
  (insert "DUMMY%"))

;; ----------------------------------------
;; keybinding
(defvar roka-mode-map nil "Keymap for `roka-mode'")
(progn
  (setq roka-mode-map (make-sparse-keymap))
  (define-key roka-mode-map (kbd "C-i C-d") 'roka-mode-cmd-insert-dummy)
  )

;; ----------------------------------------
;; Define roka-mode

;;;###autoload
(define-derived-mode roka-mode prog-mode "ROKA-MODE script"
  "ROKA-MODE mode is a major mode for editing roka rule files"
  ;; you again used quote when you had '((roka-mode-hilite))
  ;; I just updated the variable to have the proper nesting (as noted above)
  ;; and use the value directly here
  (use-local-map roka-mode-map)

  (setq font-lock-defaults
        `((
           ("'.+?'" . roka-mode-single-morpheme-face)
           ("<\\([&_a-zA-Z0-9%]+?:\\)" 1 font-lock-type-face)
           ( ,(regexp-opt roka-mode-keywords 'words) . font-lock-builtin-face)
           ( ,(regexp-opt roka-mode-constants 'words) . font-lock-constant-face)
           ("![&@_$a-zA-Z0-9]+" . font-lock-warning-face)
           ("$[&_a-zA-Z0-9]+" . font-lock-keyword-face)
           ("@[&_a-zA-Z0-9]+" . font-lock-variable-name-face)
           ;; ; : , ; { } =>  @ $ = are all special elements
           (":\\|,\\|;\\|{\\|}\\|=>\\|@\\|$\\|=" . font-lock-keyword-face)
           )))

  ;; when there's an override, use it
  ;; otherwise it gets the default value
  (when roka-mode-tab-width
    (setq tab-width roka-mode-tab-width))

  ;; for comments
  ;; overriding these vars gets you what (I think) you want
  ;; they're made buffer local when you set them
  (setq comment-start "#")
  (setq comment-end "")
  (setq comment-start "//")
  (setq comment-end "")

  (modify-syntax-entry ?# "< b" roka-mode-syntax-table)
  (modify-syntax-entry ?\n "> b" roka-mode-syntax-table)
  (modify-syntax-entry ?/ ". 14c" roka-mode-syntax-table)
  (modify-syntax-entry ?* ". 23c" roka-mode-syntax-table)

  ;; Note that there's no need to manually call `roka-mode-hook'; `define-derived-mode'
  ;; will define `roka-mode' to call it properly right before it exits
  )

(provide 'roka-mode)
(add-to-list 'auto-mode-alist '("\\.rul$" . roka-mode))

(add-hook 'roka-mode-hook '(lambda ()
			                       (electric-indent-local-mode -1)))
