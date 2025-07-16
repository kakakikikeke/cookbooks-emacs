(use-package
 copilot
 :straight
 (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
 :ensure t)
(add-hook 'css-mode-hook 'copilot-mode)
