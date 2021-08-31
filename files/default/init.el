;;; .init.el --- init config emacs

;;; Commentary:
;;;; Author: kakakikikeke
;;;; Version: 0.1

;;; Code:
; for package.el
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

; for ruby with solargraph
(require 'eglot)
(add-to-list 'eglot-server-programs '(ruby-mode . ("bundle" "exec" "solargraph" "socket" "--port" :autoport)))

; for ruby with robe
; (require 'flymake-ruby)
; (add-hook 'ruby-mode-hook 'flymake-ruby-load)
; (add-hook 'ruby-mode-hook 'robe-mode)
; (add-hook 'robe-mode-hook 'ac-robe-setup)

; for helm (install 'helm' form package.el)
(require 'helm-config)
(helm-mode 1)
(keyboard-translate ?\C-h ?\C-?)
(defvar helm-source-emacs-commands
  (helm-build-sync-source "Emacs commands"
    :candidates (lambda ()
                  (let ((cmds))
                    (mapatoms
                     (lambda (elt) (when (commandp elt) (push elt cmds))))
                    cmds))
    :coerce #'intern-soft
    :action #'command-execute)
  "A simple helm source for Emacs commands.")
(defvar helm-source-emacs-commands-history
  (helm-build-sync-source "Emacs commands history"
    :candidates (lambda ()
                  (let ((cmds))
                    (dolist (elem extended-command-history)
                      (push (intern elem) cmds))
                    cmds))
    :coerce #'intern-soft
    :action #'command-execute)
  "Emacs commands history")

(custom-set-variables
 '(helm-mini-default-sources '(helm-source-buffers-list
                               helm-source-recentf
                               helm-source-files-in-current-dir
                               helm-source-emacs-commands-history
                               helm-source-emacs-commands
                               )))

; for auto-complete (install 'auto-complete' form package.el)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-20170124.1845/dict")
(ac-config-default)
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

; for yasnippet (install 'yasnippet')
(require 'yasnippet)
(yas-global-mode 1)

;;; init.el ends here
