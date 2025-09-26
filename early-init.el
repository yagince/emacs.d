(setq package-enable-at-startup nil)

;; Speed up startup: relax GC and file-name handlers during init
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)
(defvar my/file-name-handler-alist-backup file-name-handler-alist)
(setq file-name-handler-alist nil)

;; UI要素を早期に無効化（フレーム表示前）
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; ネイティブコンパイル設定（Emacs 28+）
(when (fboundp 'native-compile-async)
  (setq native-comp-async-report-warnings-errors nil
        native-comp-deferred-compilation t))

;; Avoid expensive frame resizes and some bidi processing at startup
(setq frame-inhibit-implied-resize t
      bidi-inhibit-bpa t)

;; Restore sane defaults after startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 20 1024 1024)  ; 20MB
                  gc-cons-percentage 0.1
                  file-name-handler-alist my/file-name-handler-alist-backup)))
