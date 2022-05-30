(leaf company-mode-conf
  :config
  (leaf company
    :ensure t
    :bind ((company-active-map
            ("M-n" . nil)
            ("M-p" . nil)
            ("C-s" . company-filter-candidates)
            ("C-n" . company-select-next)
            ("C-p" . company-select-previous)
            ("<tab>" . company-complete-selection))
           (company-search-map
            ("C-n" . company-select-next)
            ("C-p" . company-select-previous))
           ("C-x y" . company-yasnippet))
    :custom ((company-idle-delay . 0)
             (company-minimum-prefix-length . 1)
             (company-transformers . '(company-sort-by-occurrence)))
    :global-minor-mode global-company-mode
    :config
    ;; (add-to-list 'company-backends 'company-yasnippet)
    )

  (leaf company-box
    :ensure t
    :after all-the-icons company
    :hook (company-mode-hook)
    :custom ((company-box-icons-alist quote company-box-icons-all-the-icons)
             (company-box-doc-enable)))
  )
