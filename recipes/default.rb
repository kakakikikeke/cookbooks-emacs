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

# install emacs
yum_package "emacs" do
  action :install
end

# config a .emacs file
if node["dot_emacs"]["write"]
  cookbook_file "dot_emacs" do
    backup 5
    path "#{node["user"]["home"]}/.emacs"
    mode 00644
    action :create
  end

  emacs_needed_dir = [
    ".emacs.d",
    ".emacs.d/backup",
    ".emacs.d/site-lisp",
  ]
  emacs_needed_dir.each do |dir|
    directory "#{node["user"]["home"]}/#{dir}" do
      mode 00644
      action :create 
    end
  end

  file "#{node["user"]["home"]}/.emacs.d/site-lisp/init.el" do
    mode 00644
    action :create
  end

  # install package.el
  if node["package"]["manage"]["install"]
    remote_file "package.el" do
      source "http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el"
      path "#{node["user"]["home"]}/.emacs.d/site-lisp/package.el"
      mode 00644
      action :create
    end

    cookbook_file "init_for_package.el" do
      backup 5
      path "#{node["user"]["home"]}/.emacs.d/site-lisp/init.el"
      mode 00644
      action :create
    end

    # install you specified packages
    if !node["package"]["install"].empty?
      node["package"]["install"].each do |pkg|
        log "package_info" do
          message pkg
          level :info
        end
        bash "install package" do
          code <<-EOC
            emacs -batch -l /root/.emacs --eval "(progn (require (quote package)) (package-initialize) (package-install (quote #{pkg})))"
          EOC
        end
      end
    end
  end
end
