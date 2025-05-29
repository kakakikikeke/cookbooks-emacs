# frozen_string_literal: true

# Install emacs
case node[:platform]
when 'ubuntu', 'centos', 'redhat', 'amazon'
  emacs_dir_name = "emacs-#{node[:version]}"
  emacs_file_name = "#{emacs_dir_name}.tar.gz"
  tmp_dir = '/tmp'

  # Download a emacs tar.xz package
  remote_file 'emacs.tar.xz' do
    source "https://ftp.jaist.ac.jp/pub/GNU/emacs/#{emacs_file_name}"
    path "#{tmp_dir}/#{emacs_file_name}"
    mode '644'
    action :create
  end

  # Execute an install script
  script 'install emacs' do
    not_if { File.exist?("#{node[:emacs_install_dir]}/emacs") }
    interpreter 'bash'
    code <<-SHELL
      cd #{tmp_dir}
      tar zvxf #{emacs_file_name}
      cd #{tmp_dir}/#{emacs_dir_name}
      sh ./configure --with-x-toolkit=no
      make
      make install
    SHELL
  end
when 'mac_os_x'
  execute 'update homebrew' do
    command 'brew update'
  end

  # Install with Homebrew
  execute 'install emacs via homebrew' do
    command "#{node[:emacs_install_dir]}/brew install emacs"
    not_if "#{node[:emacs_install_dir]}/brew list emacs"
  end
end
