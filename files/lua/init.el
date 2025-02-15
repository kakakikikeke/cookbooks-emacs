; for lua
(add-hook 'lua-mode-hook
  (lambda ()
    (company-mode 1)
    (abbrev-mode 1)))
