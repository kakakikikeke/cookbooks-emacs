# cookbooks-emacs
Install emacs by chef cookbooks.

## Supported Platform

* CentOS
* Ubuntu

## Install
How to run vagrant user on Ubuntu16.04.

* Install chef-solo command

```
curl -L https://omnitruck.chef.io/install.sh | sudo bash
chef-solo -v
```

* Deploy cookbooks

```
sudo yum -y install git
mkdir -p ~/chef-repo/cookbooks
mkdir -p ~/chef-repo/roles
mkdir -p /tmp/chef-solo/
cd ~/chef-repo/cookbooks
git clone git://github.com/kakakikikeke/cookbooks-emacs.git
```

```
cat << EOF > ~/chef-repo/cookbooks/cookbooks-emacs.json
{
  "run_list": [
    "recipe[cookbooks-emacs]"
  ]
}
EOF
```

```
cat << EOF > ~/chef-repo/client.rb
  file_cache_path "/tmp/chef-solo"
  cookbook_path ["~/chef-repo/cookbooks"]
  role_path "~/chef-repo/roles"
  log_level :debug
EOF
```

* Execute chef-solo

```
sudo chef-solo -c ~/chef-repo/client.rb -j cookbooks-emacs.json
```

After installed, you can use emacs.

```
/usr/local/bin/emacs
```
