# frozen_string_literal: true

# Put ruby-mode,python-mode snippet files
if node[:snippets][:put]

  snippets_needed_dir = [
    '.emacs.d/snippets'
  ]

  snippets_needed_dir.each do |dir|
    directory "#{node[:home_dir]}/#{dir}" do
      owner node[:owner]
      group node[:group]
      mode '775'
      action :create
      recursive true
    end
  end

  %w[ruby python].each do |lang|
    remote_directory "#{node[:home_dir]}/.emacs.d/snippets/#{lang}-mode" do
      source "snippets/#{lang}-mode"
      files_owner node[:owner]
      files_group node[:group]
      files_mode '644'
      owner node[:owner]
      group node[:group]
      mode '775'
      action :create
      recursive true
    end
  end

end
