; for sort-buffers
(defun sort-buffers ()
  "Put the buffer list in alphabetical order."
  (interactive)
  (dolist (buff (buffer-list-sorted)) (bury-buffer buff))
  (when (interactive-p) (list-buffers)))
  (defun buffer-list-sorted ()
    (sort (buffer-list)
    (function
      (lambda
        (a b) (string<
        (downcase (buffer-name a))
        (downcase (buffer-name b)))))))
