(use-package company
  :defer t
  :config
  (bind-keys :map company-active-map
             ("C-n" . company-select-next)
             ("C-p" . company-select-previous)
             ("C-n" . company-select-next)
             ("C-p" . company-select-previous)
             ("C-s" . company-filter-candidates)
             ("M-/" . company-complete-selection)
             )
  )

(use-package company-box
  :after (company all-the-icons)
  :hook ((company-mode . company-box-mode))
  :custom
  (company-box-icons-alist 'company-box-icons-all-the-icons)
  (company-box-doc-enable nil))
