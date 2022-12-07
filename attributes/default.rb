default[:version] = ENV['VERSION'] || '28.2'
default[:owner] = ENV['OWNER'] || 'vagrant'
default[:group] = ENV['GROUP'] || 'vagrant'
default[:dot_emacs][:write] = true
default[:snippets][:put] = true
default[:package][:install] = [
  ### for omni completion
  "helm",
  "auto-complete",
  "company",
  ### for snippet
  "yasnippet",
  ### for ruby
  "ruby-mode",
  "rbenv",
  "robe",
  "inf-ruby",
  "flymake-ruby",
  ### for lsp
  "helm-lsp",
  "lsp-mode",
  # "eglot",
  ### for side pain
  "treemacs",
  "projectile",
  # vue
  "mmm-mode",
  "web-mode",
]
