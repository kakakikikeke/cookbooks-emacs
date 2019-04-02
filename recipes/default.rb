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

home_dir = node['etc']['passwd'][node['current_user']]['dir']
packages = [
  "gcc",
  "make",
]
# install required packages
case node[:platform]
when "ubuntu"
  packages.concat [
    "libncurses5-dev",
    "libxpm-dev",
    "libjpeg8-dev",
    "libpng12-dev",
    "libgif-dev",
    "libtiff5-dev",
    "libgnutls-dev"
  ]
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

emacs_dir_name="emacs-#{node[:version]}"
emacs_file_name="#{emacs_dir_name}.tar.gz"
tmp_dir="/tmp"
# download a emacs tar.gz package
remote_file "emacs.tar.gz" do
  source "http://ftp.gnu.org/gnu/emacs/#{emacs_file_name}"
  path "#{tmp_dir}/#{emacs_file_name}"
  mode 00644
  action :create
end

# install emacs
script "install emacs" do
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

# config a .emacs file
if node[:dot_emacs][:write]

  cookbook_file "dot_emacs" do
    backup 5
    path "#{home_dir}/.emacs"
    mode 00644
    action :create
  end

  emacs_needed_dir = [
    ".emacs.d",
    ".emacs.d/backup",
    ".emacs.d/site-lisp",
  ]

  emacs_needed_dir.each do |dir|
    directory "#{home_dir}/#{dir}" do
      mode 00644
      action :create
    end
  end

  cookbook_file "init_for_package.el" do
    backup 5
    path "#{home_dir}/.emacs.d/site-lisp/init.el"
    mode 00644
    action :create
  end

end

emacs_install_dir="/usr/local/bin"
# install specified elisp package used by package.el
if !node[:package][:install].empty?
  node[:package][:install].each do |pkg|
    log "package_info" do
      message pkg
      level :info
    end
    bash "install package" do
      code <<-EOC
        "#{emacs_install_dir}/"emacs -batch -l #{home_dir}/.emacs --eval "(progn (require (quote package)) (package-list-packages) (package-install (quote #{pkg})))"
      EOC
    end
  end
end
