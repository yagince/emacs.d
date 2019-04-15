(global-set-key "\C-h" 'backward-delete-char)
(define-key global-map [?¥] [?\\])
(define-key global-map (kbd "C-z") nil)

(use-package goto-chg
  :commands(goto-last-change
            goto-last-change-reverse
            )
  :bind (("<f8>" . goto-last-change)
         ("M-<f8>" . goto-last-change-reverse))
  :config
  ;; any settings...
  )
