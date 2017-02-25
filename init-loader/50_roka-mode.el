(defvar roka-mode-constants
  '("$BOS" "$EOS"
    "名詞" "サ変接続" "接頭詞"
    "動詞"
    "助詞" "助動詞"
    "形容詞" "副詞"
    ))

(defvar roka-mode-keywords
  '("include"))

;; I'd probably put in a default that you want, as opposed to nil
(defvar roka-mode-tab-width 0 "Width of a tab for ROKA-MODE mode")

;;;###autoload
(define-derived-mode roka-mode ruby-mode "ROKA-MODE script"
  "ROKA-MODE mode is a major mode for editing roka rule files"
  ;; you again used quote when you had '((roka-mode-hilite))
  ;; I just updated the variable to have the proper nesting (as noted above)
  ;; and use the value directly here

  (setq font-lock-defaults `((
     ("![@_$a-zA-Z]+" . font-lock-warning-face)
     ("$[_a-zA-Z]+" . font-lock-keyword-face)
     ("@[_a-zA-Z]+" . font-lock-variable-name-face)
     ;; stuff between double quotes
     ("\"\\.\\*\\?" . font-lock-string-face)
     ;; ; : , ; { } =>  @ $ = are all special elements
     (":\\|,\\|;\\|{\\|}\\|=>\\|@\\|$\\|=" . font-lock-keyword-face)
     ( ,(regexp-opt roka-mode-keywords 'words) . font-lock-builtin-face)
     ( ,(regexp-opt roka-mode-constants 'words) . font-lock-constant-face)
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

  (modify-syntax-entry ?/ ". 14b")
  (modify-syntax-entry ?* ". 23b")
  (modify-syntax-entry ?\" "\"")
  (modify-syntax-entry ?\' "\"")

  ;; Note that there's no need to manually call `roka-mode-hook'; `define-derived-mode'
  ;; will define `roka-mode' to call it properly right before it exits
  )

(provide 'roka-mode)
(add-to-list 'auto-mode-alist '("\\.rul$" . roka-mode))
