# frozen_string_literal: true

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

include_recipe 'cookbooks-emacs::install_package'
include_recipe 'cookbooks-emacs::install_emacs'
include_recipe 'cookbooks-emacs::install_emacs_package'
include_recipe 'cookbooks-emacs::put_emacs_file'
include_recipe 'cookbooks-emacs::put_snippet'
