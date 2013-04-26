define :make_install, :path => "/tmp/", :test_flg => true, :configure_flg => true do
  bash "make" do
    user "root"
    cwd #{params[:path]}
    code <<-EOF
      if [ #{params[:configure_flg]} = "true" ]
      then
        cd #{params[:path]}
        sh configure
      fi
      cd #{params[:path]}
      make
      if [ #{params[:test_flg]} = "true" ]
      then
        cd #{params[:path]}
        make test
      fi
      cd #{params[:path]}
      make install
    EOF
  end
end

define :emacs_w3m_install, :to_path => "/tmp/", :from_path => "/tmp/", :configure_flg => true do
  bash "make" do
    user "root"
    cwd #{params[:to_path]}
    code <<-EOF
      y|cp -ipr #{params[:from_path]}/* #{params[:to_path]}
      cd #{params[:to_path]}
      if [ #{params[:configure_flg]} = "true" ]
      then
        cd #{params[:to_path]}
        sh configure
      fi
      cd #{params[:to_path]}
      make clean
      cd #{params[:to_path]}
      make
      cd #{params[:to_path]}
      make install
    EOF
  end
end
