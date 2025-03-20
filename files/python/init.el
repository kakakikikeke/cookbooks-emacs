; for python lsp with lsp-pyright (needs to install pyright globally via pip command)
; (add-hook 'python-mode-hook #'lsp)
(add-hook
 'python-mode-hook
 #'(lambda () (define-key python-mode-map "\C-c\C-p" 'treemacs)))
(leaf
 lsp-pyright
 :ensure t
 :require t
 :after python
 :defvar lsp-pyright-venv-path
 :init
 (setq
  lsp-pyright-venv-path
  "/Users/kakakikikeke/.local/share/virtualenvs/python-try-aR_k1rUJ")
 :hook (python-mode-hook . lsp))

; for copilot (with straight)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el"
                         (or (bound-and-true-p straight-base-dir)
                             user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent
         'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(use-package
 copilot
 :straight
 (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
 :ensure t)
(add-hook 'python-mode-hook 'copilot-mode)
