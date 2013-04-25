define :decompress, :path => "/tmp/", :tar_file => "" do
  bash "decompress_tar" do
    user "root"
    cwd #{params[:path]}
    code <<-EOF
    cd #{params[:path]}
    tar xvf #{params[:tar_file]}
    EOF
  end
end

define :zdecompress, :path => "/tmp/", :tar_file => "" do
  bash "zdecompress_tar" do
    user "root"
    cwd #{params[:path]}
    code <<-EOF
    cd #{params[:path]}
    tar zxvf #{params[:tar_file]}
    EOF
  end
end
