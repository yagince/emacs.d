(setq package-enable-at-startup nil)

;; Speed up startup: relax GC and file-name handlers during init
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)
(defvar my/file-name-handler-alist-backup file-name-handler-alist)
(setq file-name-handler-alist nil)

;; Avoid expensive frame resizes and some bidi processing at startup
(setq frame-inhibit-implied-resize t
      bidi-inhibit-bpa t)

;; Restore sane defaults after startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold 134217728   ; 128MB
                  gc-cons-percentage 0.1
                  file-name-handler-alist my/file-name-handler-alist-backup)))
