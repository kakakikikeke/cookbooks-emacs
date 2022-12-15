default[:version] = ENV['VERSION'] || '28.2'
default[:owner] = ENV['OWNER'] || 'vagrant'
default[:group] = ENV['GROUP'] || 'vagrant'
default[:dot_emacs][:write] = true
default[:snippets][:put] = true
default[:package][:install] = [
  ### for omni completion
  "helm",
  "company",
  # "auto-complete",
  ### for snippet
  "yasnippet",
  ### for ruby
  "ruby-mode",
  "rbenv",
  "robe",
  "inf-ruby",
  "flymake-ruby",
  ### for python
  "lsp-pyright",
  ### for lsp
  "helm-lsp",
  "lsp-mode",
  # "eglot",
  ### for side pain
  "treemacs",
  "projectile",
  ### for vue
  "mmm-mode",
  "web-mode",
]
