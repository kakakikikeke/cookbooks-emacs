for file_name in `git ls-files files | egrep -e 'el|emacs'`
do
emacs --batch $file_name -l ~/.emacs.d/elpa/elisp-autofmt-*/elisp-autofmt.el --eval "
(progn
  (let ((use-stdout nil))
    (dolist (buf (buffer-list))
      (with-current-buffer buf
        (when (buffer-file-name)
          (setq buffer-undo-list t) ;; Disable undo.
          (if use-stdout
              (progn
                (elisp-autofmt-buffer)
                (princ (buffer-substring-no-properties (point-min) (point-max))))
            (princ buffer-file-name)
            (princ \"\n\")
            (elisp-autofmt-buffer-to-file)))))))"
done
