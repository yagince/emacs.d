;;; -*- lexical-binding: t; -*-

(defun image-tooltip-at-point ()
  "ポイントやマウスカーソルの下の画像ファイルをツールチップ内に表示します。

使い方:
 (define-key c-mode-map \"\\C-co\" 'image-tooltip-at-point)
 (define-key c-mode-map [mouse-1] 'image-tooltip-at-point)

./very-sorry.png
./very-sorry.gif

上記のようなファイル名を`ffap'が認識出来れば C-c o やマウス左クリックでポップアップします。"
  (interactive)
  (unless (display-graphic-p)
    (error "Window system required."))
  (require 'ffap)
  (let ((file (ffap-file-at-point)))
    (when file
      (unless (and (stringp file)
                   (not (directory-name-p file))
                   (file-exists-p (setq file (expand-file-name file))))
        (error "File not found."))
      (when (image-type-from-file-name file)
        (let* ((x-y (window-absolute-pixel-position))
               (tooltip-frame-parameters `((left . ,(+ (car x-y) tooltip-x-offset))
                                           (top . ,(+ (cdr x-y) tooltip-y-offset))
                                           (internal-border-width . 0)
                                           (border-width . 0)))
               (image (create-image file))
               (x-gtk-use-system-tooltips nil)) ; Linux ではこれしないと表示されない…
          (image-animate image)
          (tooltip-show (propertize "a" 'display image)))))))


(define-key c-mode-map "\C-co" 'image-tooltip-at-point)
(define-key c-mode-map [mouse-1] 'image-tooltip-at-point)
