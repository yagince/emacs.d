(leaf company-mode-conf
  :config
  (leaf company
    :ensure t
    :after t
    :config
    (bind-key "C-n" #'company-select-next company-active-map nil)
    (bind-key "C-p" #'company-select-previous company-active-map nil)
    (bind-key "C-s" #'company-filter-candidates company-active-map nil)
    (bind-key "M-/" #'company-complete-selection company-active-map nil))

  (leaf company-box
    :ensure t
    :after all-the-icons company
    :hook (company-mode-hook)
    :custom ((company-box-icons-alist quote company-box-icons-all-the-icons)
             (company-box-doc-enable))))


;; (use-package company
;;   :defer t
;;   :config
;;   (bind-keys :map company-active-map
;;              ("C-n" . company-select-next)
;;              ("C-p" . company-select-previous)
;;              ("C-n" . company-select-next)
;;              ("C-p" . company-select-previous)
;;              ("C-s" . company-filter-candidates)
;;              ("M-/" . company-complete-selection)
;;              )
;;   )

;; (use-package company-box
;;   :after (company all-the-icons)
;;   :hook ((company-mode . company-box-mode))
;;   :custom
;;   (company-box-icons-alist 'company-box-icons-all-the-icons)
;;   (company-box-doc-enable nil))
