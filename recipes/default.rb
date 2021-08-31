#
# Cookbook Name:: cookbooks-emacs
# Recipe:: default
#
# Copyright 2015, kakakikikeke
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

home_dir = ENV["HOME"]
packages = [
  "gcc",
  "make",
]
emacs_install_dir="/usr/local/bin"

# Install required packages
case node[:platform]
when "ubuntu"
  packages.concat [
    "libncurses5-dev",
    "libxpm-dev",
    "libjpeg8-dev",
    "libgif-dev",
    "libtiff5-dev",
  ]
  case node[:platform_version].to_i
  when 18
    packages.concat [
      "libpng-dev",
      "libgnutls28-dev"
    ]
  else
    packages.concat [
      "libpng12-dev",
      "libgnutls-dev"
    ]
  end
  packages.each do |package|
    apt_package package do
      action :install
    end
  end
when "centos", "redhat", "amazon"
  package.concat [
    "ncurses-devel",
    "libXpm-devel",
    "libjpeg-devel",
    "libpng-devel",
    "libgif-devel",
    "libtiff-devel",
    "gnutls-devel"
  ]
  yum_package package do
    action :install
  end
end

# Install emacs
case node[:platform]
when "ubuntu", "centos", "redhat", "amazon"
  emacs_dir_name="emacs-#{node[:version]}"
  emacs_file_name="#{emacs_dir_name}.tar.gz"
  tmp_dir="/tmp"

  # Download a emacs tar.gz package
  remote_file "emacs.tar.gz" do
    source "http://ftp.gnu.org/gnu/emacs/#{emacs_file_name}"
    path "#{tmp_dir}/#{emacs_file_name}"
    mode "644"
    action :create
  end

  # Execute an install script
  script "install emacs" do
    not_if { File.exists?("#{emacs_install_dir}/emacs") }
    interpreter "bash"
    code <<-EOL
      cd #{tmp_dir}
      tar zvxf #{emacs_file_name}
      cd #{tmp_dir}/#{emacs_dir_name}
      sh ./configure --with-x-toolkit=no
      make
      make install
    EOL
  end
when "mac_os_x"
  # Install with Homebrew
  homebrew_package "Install emacs with Homebrew" do
    package_name "emacs"
    action :install
  end
end

# Touch default .emacs
cookbook_file "#{home_dir}/.emacs" do
  backup 5
  source "default_dot_emacs"
  mode "644"
  owner "#{node[:owner]}"
  group "#{node[:group]}"
  action :create
end

# Install specified elisp package used by package.el
if !node[:package][:install].empty?
  node[:package][:install].each do |pkg|
    log "package_info" do
      message pkg
      level :info
    end
    bash "update packages" do
      code <<-EOC
        "#{emacs_install_dir}/"emacs -batch -l #{home_dir}/.emacs -q --eval "(progn (require (quote package)) (package-refresh-contents))"
      EOC
    end
    bash "install package" do
      code <<-EOC
        "#{emacs_install_dir}/"emacs -batch -l #{home_dir}/.emacs --eval "(progn (require (quote package)) (package-list-packages) (package-install (quote #{pkg})))"
      EOC
    end
  end
end

# Put a customized .emacs file
if node[:dot_emacs][:write]

  cookbook_file "#{home_dir}/.emacs" do
    backup 5
    source "dot_emacs"
    owner "#{node[:owner]}"
    group "#{node[:group]}"
    mode "644"
    action :create
  end

  emacs_needed_dir = [
    ".emacs.d/backup",
    ".emacs.d/site-lisp",
  ]

  emacs_needed_dir.each do |dir|
    directory "#{home_dir}/#{dir}" do
      owner "#{node[:owner]}"
      group "#{node[:group]}"
      mode "775"
      action :create
      recursive true
    end
  end

  cookbook_file "#{home_dir}/.emacs.d/site-lisp/init.el" do
    backup 5
    source "init.el"
    owner "#{node[:owner]}"
    group "#{node[:group]}"
    mode "644"
    action :create
  end

end

# Put ruby-mode snippet files
if node[:snippets][:put]

  snippets_needed_dir = [
    ".emacs.d/snippets",
  ]

  snippets_needed_dir.each do |dir|
    directory "#{home_dir}/#{dir}" do
      owner "#{node[:owner]}"
      group "#{node[:group]}"
      mode "775"
      action :create
      recursive true
    end
  end

  remote_directory "#{home_dir}/.emacs.d/snippets/ruby-mode" do
    source "snippets/ruby-mode"
    files_owner "#{node[:owner]}"
    files_group "#{node[:group]}"
    files_mode "644"
    owner "#{node[:owner]}"
    group "#{node[:group]}"
    mode "775"
    action :create
    recursive true
  end

end
