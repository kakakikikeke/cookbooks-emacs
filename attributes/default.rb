default[:version] = ENV['VERSION'] || '28.2'
default[:owner] = ENV['OWNER'] || 'vagrant'
default[:group] = ENV['GROUP'] || 'vagrant'
default[:dot_emacs][:write] = true
default[:snippets][:put] = true
default[:package][:install] = [
  "helm",
  "auto-complete",
  "yasnippet",
  "ruby-mode",
  "robe",
  "flymake-ruby",
  "eglot",
  "lsp-mode",
  "treemacs",
  "projectile",
  "mmm-mode",
  "web-mode",
]
