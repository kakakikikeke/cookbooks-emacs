#
# Cookbook Name:: cookbooks-emacs 
# Recipe:: default
#
# Copyright 2013, kakakikikeke
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

if node["network"]
  %w{ncurses-devel make gcc w3m}.each do |pkg|
    yum_package "#{pkg}" do
      action :install
    end
  end
end

if node["emacs"]["install"]["full"]
  cookbook_file "dot_emacs" do
    backup 5
    path "#{node["emacs"]["dir"]}.emacs"
    mode 00644
    action :create
  end

  remote_directory "dot_emacs.d" do
    files_backup 5
    path "#{node["emacs"]["dir"]}.emacs.d"
    owner "root"
    group "root"
    files_owner "root"
    files_group "root" 
    files_mode 00644
    recursive true
    action :create
    purge true
  end
else 
  cookbook_file "dot_emacs_simple" do
    backup 5
    path "#{node["emacs"]["dir"]}.emacs"
    mode 00644
    action :create
  end

  directory "#{node["emacs"]["dir"]}.emacs.d" do
    owner "root"
    group "root"
    mode 00644
    action :create  
  end

  directory "#{node["emacs"]["dir"]}.emacs.d/backup" do
    owner "root"
    group "root"
    mode 00644
    action :create  
  end
end

cookbook_file "emacs-w3m-1.4.4.tar.gz" do
  path "#{node["emacs"]["tar_save_dir"]}emacs-w3m-1.4.4.tar.gz"
  mode 00644
  action :create
end

zdecompress "w3m-master-tar" do
  path "#{node["emacs"]["tar_save_dir"]}"
  tar_file "emacs-w3m-1.4.4.tar.gz"
end

cookbook_file "emacs-w3m.tar" do
  path "#{node["emacs"]["tar_save_dir"]}emacs-w3m.tar"
  mode 00644
  action :create
end

decompress "w3m-slave-tar" do
  path "#{node["emacs"]["tar_save_dir"]}"
  tar_file "emacs-w3m.tar"
end

#emacs_w3m_install "emacs-w3m-install" do
#  to_path "emacs-w3m-1.4.4"
#  from_path "emacs-w3m"
#end

cookbook_file "emacs-23.4.tar.gz" do
  path "#{node["emacs"]["tar_save_dir"]}emacs-23.4.tar.gz"
  mode 00644
  action :create
end

decompress "emacs-tar" do
  path "#{node["emacs"]["tar_save_dir"]}"
  tar_file "emacs-23.4.tar.gz"
end

make_install "emacs-install" do
  path "#{node["emacs"]["tar_save_dir"]}emacs-23.4"
  test_flg true
  configure_flg true
end

