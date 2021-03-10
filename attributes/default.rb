default[:version] = ENV['VERSION'] || '27.1'
default[:owner] = ENV['OWNER'] || 'vagrant'
default[:group] = ENV['GROUP'] || 'vagrant'
default[:dot_emacs][:write] = true
default[:snippets][:put] = true
default[:package][:install] = [
  "helm",
  "auto-complete",
  "yasnippet",
  "ruby-mode",
  "robe"
]
