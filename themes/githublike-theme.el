;;; githublike-theme.el

(deftheme githublike
  "A theme like github styles.")

(custom-theme-set-faces 'githublike
  '(default
     ((t (:stipple nil
  	  :background "#ffffff"
  	  :foreground "#505050"
  	  :inverse-video nil
  	  :box nil
  	  :strike-through nil
   	  :overline nil
  	  :underline nil
  	  :slant normal
  	  :weight normal
  	  ; :height 1
  	  :width normal
  	  :foundry "outline"
  	  :family "Bitstream Vera Sans Mono"))))

  '(bold ((t (:weight bold))))
  '(italic ((t (:slant italic))))
  '(bold-italic ((t (:slant italic :weight bold))))
  ; Region color is default selection color in FireFox.
  '(region ((t (:background "#a8d1ff"))))
  '(font-lock-comment-face ((t (:foreground "#909080"
				:slant italic))))
  '(font-lock-string-face ((t (:foreground "#900000"))))
  '(font-lock-keyword-face ((t (:foreground "black"
				:weight bold))))
  '(font-lock-builtin-face ((t (:foreground "black"
			        :weight bold))))
  '(font-lock-function-name-face ((t (:foreground "#900000"
				      :weight bold))))
  '(font-lock-variable-name-face ((t (:foreground "#008080")))) ; teal
  '(font-lock-type-face ((t (:foreground "#008080"))))          ; teal
  '(font-lock-constant-face ((t (:foreground "#990073"))))
  '(font-lock-warning-face ((t (:foreground "red")))))

(provide-theme 'githublike)

;;; githublike-theme.el ends here