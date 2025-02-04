;;; .init.el --- init config emacs

;;; Commentary:
;;;; Author: kakakikikeke
;;;; Version: 0.2

;;; Code:
; for package.el
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

; for rbenv
(global-rbenv-mode)

; for highlight-symbol
; (require 'auto-highlight-symbol)
; (global-auto-highlight-symbol-mode t)

; for ruby lsp with lsp-mode (needs to install solargraph globally via gem command)
(require 'lsp-mode)
; (setq lsp-solargraph-use-bundler t)
(add-hook 'ruby-mode-hook 'lsp)

; for ruby lsp with eglot
; (require 'eglot)
; (add-to-list 'eglot-server-programs '(ruby-mode . ("bundle" "exec" "solargraph" "socket" "--port" :autoport)))

; for ruby with robe
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)
(add-hook 'ruby-mode-hook 'robe-mode)
(eval-after-load 'company
  '(push 'company-robe company-backends))

(defun restart-pry-buffer ()
  "Restart the Pry buffer by killing it and starting robe again."
  (interactive)
  (let ((pry-buffer (get-buffer "*pry*"))
        (kill-buffer-query-functions nil)
        (kill-buffer-hook nil))
    (when pry-buffer
      (kill-buffer pry-buffer)))
  (robe-start))

; for python lsp with lsp-pyright (needs to install pyright globally via pip command)
; (add-hook 'python-mode-hook #'lsp)
(add-hook
 'python-mode-hook
 '(lambda ()
    (define-key python-mode-map "\C-c\C-p" 'treemacs)))
(leaf lsp-pyright
  :ensure t
  :require t
  :after python
  :defvar lsp-pyright-venv-path
  :init
  (setq lsp-pyright-venv-path "/Users/kakakikikeke/.local/share/virtualenvs/app-xxx")
  :hook
  (python-mode-hook . lsp))

; for java lsp with Eclipse JDT Language Server
; (require 'lsp-java)
; (add-hook 'java-mode-hook
;   (lambda ()
;     (setq lsp-java-jdt-download-url "https://www.eclipse.org/downloads/download.php?file=/jdtls/milestones/1.37.0/jdt-language-server-1.37.0-202406271335.tar.gz")
;     (setq lsp-java-format-enabled nil)
;     (setq lsp-java-format-on-type-enabled nil)
;     (setq tab-width 2)
;     (setq-default indent-tabs-mode nil)
;     (lsp)))

; for lisp
(add-hook 'emacs-lisp-mode-hook 'company-mode)
(add-hook 'lisp-mode-hook 'company-mode)

; for lua
(add-hook 'lua-mode-hook
  (lambda ()
    (company-mode 1)
    (abbrev-mode 1)))

; for copilot (with straight)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
  :ensure t)
(add-hook 'python-mode-hook 'copilot-mode)

; for helm (install 'helm' form package.el)
; (require 'helm-config) Cannot open load file, No such file or directory, helm-config
(require 'helm)
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
; (require 'auto-complete-config)
; (add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-20170124.1845/dict")
; (ac-config-default)
; (setq ac-use-menu-map t)
; (define-key ac-menu-map "\C-n" 'ac-next)
; (define-key ac-menu-map "\C-p" 'ac-previous)

; for yasnippet (install 'yasnippet')
(require 'yasnippet)
(yas-global-mode 1)

; for treemacs
(setq treemacs-width 25)
(save-selected-window (treemacs-select-window))

; for mmm-mode
(require 'mmm-mode)
(setq mmm-global-mode 'maybe)
(setq mmm-submode-decoration-level 0)

; for web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))

;;; init.el ends here
