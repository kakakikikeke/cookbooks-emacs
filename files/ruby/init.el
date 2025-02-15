; for rbenv
(global-rbenv-mode)

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

; for web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
