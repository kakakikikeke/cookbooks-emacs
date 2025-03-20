; for lisp
(add-hook 'emacs-lisp-mode-hook 'company-mode)
(add-hook 'emacs-lisp-mode-hook 'elisp-autofmt-mode)
(add-hook 'lisp-mode-hook 'company-mode)
(add-hook 'lisp-mode-hook 'elisp-autofmt-mode)
(defun my-elisp-before-save-hook ()
  "Emacs Lisp のファイルを保存するときにのみ実行する before-save-hook."
  (when (eq major-mode 'emacs-lisp-mode)
    (message "Saving Emacs Lisp file: %s" buffer-file-name)
    (elisp-autofmt-buffer)))

;; フックの登録
(add-hook 'before-save-hook #'my-elisp-before-save-hook)
