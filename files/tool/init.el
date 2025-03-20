; for yasnippet (install 'yasnippet')
(require 'yasnippet)
(yas-global-mode 1)

; for treemacs
(setq treemacs-width 25)
(save-selected-window
  (treemacs-select-window))

; for mmm-mode
(require 'mmm-mode)
(setq mmm-global-mode 'maybe)
(setq mmm-submode-decoration-level 0)
