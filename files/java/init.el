; for java lsp with Eclipse JDT Language Server
(require 'lsp-java)
(add-hook 'java-mode-hook
  (lambda ()
    (setq lsp-java-jdt-download-url "https://www.eclipse.org/downloads/download.php?file=/jdtls/milestones/1.37.0/jdt-language-server-1.37.0-202406271335.tar.gz")
    (setq lsp-java-format-enabled nil)
    (setq lsp-java-format-on-type-enabled nil)
    (setq tab-width 2)
    (setq-default indent-tabs-mode nil)
    (lsp)))
