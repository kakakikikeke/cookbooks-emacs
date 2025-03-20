; for clipborad
(setq sysname system-type)
(if (eq sysname 'darwin)
    (progn
      (defun copy-from-osx ()
        (shell-command-to-string
         "reattach-to-user-namespace pbpaste"))
      (defun paste-to-osx (text &optional push)
        (let ((process-connection-type nil))
          (let ((proc
                 (start-process
                  "pbcopy" "*Messages*" "reattach-to-user-namespace"
                  "pbcopy")))
            (process-send-string proc text)
            (process-send-eof proc))))
      (setq interprogram-cut-function 'paste-to-osx)
      (setq interprogram-paste-function 'copy-from-osx))
  (message "This platform is not mac"))
(if (eq sysname 'cygwin)
    (progn
      (defun paste-from-cygwin ()
        (with-temp-buffer
          (insert-file-contents "/dev/clipboard")
          (buffer-string)))
      (defun cut-to-cygwin (text &optional push)
        (with-temp-file "/dev/clipboard"
          (insert text)))
      (setq interprogram-cut-function 'cut-to-cygwin)
      (setq interprogram-paste-function 'paste-from-cygwin))
  (message "This platform is not cygwin"))
