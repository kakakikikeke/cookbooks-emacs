; for electric-indent
(electric-indent-mode 0)
(setq truncate-lines t)
(setq truncate-partial-width-windows t)

; for end character
(set-display-table-slot standard-display-table 'wrap ? )

; for highlight
(global-hl-line-mode t)
(custom-set-faces
 '(hl-line ((t (:background "SteelBlue4")))))

; for number of character selected region
(line-number-mode t)
(column-number-mode t)
(defun count-lines-and-chars ()
  (if mark-active
      (format "[%3d:%4d]"
	      (count-lines (region-beginning) (region-end))
	      (- (region-end) (region-beginning)))
    ""))
; (add-to-list 'default-mode-line-format '(:eval (count-lines-and-chars)))

; for igonre case sensitive
(custom-set-variables '(read-file-name-completion-ignore-case t))

; for highlight corresponding brackets
(show-paren-mode t)

; for using only one buffer at startup even if multiple files are open
(add-hook 'window-setup-hook 'delete-other-windows)

; for backup folder
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))
