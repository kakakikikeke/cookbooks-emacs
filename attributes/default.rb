# frozen_string_literal: true

default[:version] = ENV['VERSION'] || '30.1'
default[:owner] = ENV['OWNER'] || 'vagrant'
default[:group] = ENV['GROUP'] || 'vagrant'
default[:dot_emacs][:write] = true
default[:snippets][:put] = true
default[:emacs_install_dir] = ENV['EMACS_INSTALL_DIR'] || '/usr/local/bin'
default[:emacs_site_lisp_dir] = '.emacs.d/site-lisp'
default[:home_dir] = ENV['HOME']
default[:package][:install] = [
  ### for omni completion
  'helm',
  'company',
  # 'auto-complete',
  ### for snippet
  'yasnippet',
  ### for ruby
  'ruby-mode',
  'rbenv',
  'robe',
  'inf-ruby',
  'flymake-ruby',
  ### for python
  'lsp-pyright',
  'pipenv',
  ### for lsp
  'helm-lsp',
  'lsp-mode',
  # 'eglot',
  ### for side pain
  'treemacs',
  'projectile',
  ### for vue
  'mmm-mode',
  'web-mode',
  ### for utils
  'leaf',
  ### for java
  'lsp-java',
  ### for lsp
  'elisp-autofmt'
]
