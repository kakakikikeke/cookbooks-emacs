# frozen_string_literal: true

# Put a customized .emacs file
if node[:dot_emacs][:write]

  cookbook_file "#{node[:home_dir]}/.emacs" do
    backup 5
    source 'dot_emacs'
    owner node[:owner]
    group node[:group]
    mode '644'
    action :create
  end

  emacs_needed_dir = [
    '.emacs.d/backup',
    node[:emacs_site_lisp_dir],
    "#{node[:emacs_site_lisp_dir]}/common_clipboard",
    "#{node[:emacs_site_lisp_dir]}/common_func",
    "#{node[:emacs_site_lisp_dir]}/common_keybind",
    "#{node[:emacs_site_lisp_dir]}/common_ui",
    "#{node[:emacs_site_lisp_dir]}/do_not_use",
    "#{node[:emacs_site_lisp_dir]}/helm",
    "#{node[:emacs_site_lisp_dir]}/java",
    "#{node[:emacs_site_lisp_dir]}/lisp",
    "#{node[:emacs_site_lisp_dir]}/lua",
    "#{node[:emacs_site_lisp_dir]}/css",
    "#{node[:emacs_site_lisp_dir]}/package",
    "#{node[:emacs_site_lisp_dir]}/python",
    "#{node[:emacs_site_lisp_dir]}/ruby",
    "#{node[:emacs_site_lisp_dir]}/tool"
  ]

  emacs_needed_dir.each do |dir|
    directory "#{node[:home_dir]}/#{dir}" do
      owner node[:owner]
      group node[:group]
      mode '775'
      action :create
      recursive true
    end

    next if emacs_needed_dir.first(2).any? { |d| dir == d }

    cookbook_file_dir = dir.gsub(node[:emacs_site_lisp_dir], '')
    cookbook_file "#{node[:home_dir]}/#{dir}/init.el" do
      backup 5
      source "#{cookbook_file_dir}/init.el"
      owner node[:owner]
      group node[:group]
      mode '644'
      action :create
    end
  end

end
