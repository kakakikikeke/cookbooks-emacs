# frozen_string_literal: true

# Touch default .emacs
cookbook_file "#{node[:home_dir]}/.emacs" do
  backup 5
  source 'default_dot_emacs'
  mode '644'
  owner node[:owner]
  group node[:group]
  action :create
end

# Install specified elisp package used by package.el
unless node[:package][:install].empty?
  bash 'update packages' do
    code <<-EMACS_COMMAND
      #{node[:emacs_install_dir]}/emacs -batch -l #{node[:home_dir]}/.emacs -q --eval '(progn (require (quote package)) (package-refresh-contents))'
    EMACS_COMMAND
  end

  node[:package][:install].each do |pkg|
    log 'package_info' do
      message "Installing an emacs pacakge of #{pkg}"
      level :info
    end
    bash 'install package' do
      code <<-EMACS_COMMAND
        #{node[:emacs_install_dir]}/emacs -batch -l #{node[:home_dir]}/.emacs -q --eval '(progn (require (quote package)) (package-list-packages) (package-install (quote #{pkg})))'
      EMACS_COMMAND
    end
  end
end
