# cookbooks-emacs
Install emacs by chef cookbooks.

## Supported Platform

* CentOS
* Ubuntu

## Install

* Install chef-solo command

```
sudo true && curl -L https://www.opscode.com/chef/install.sh | sudo bash
chef-solo -v
```

* Deploy cookbooks

```
mkdir -p /chef-repo/cookbooks
mkdir -p /chef-repo/roles
mkdir -p /etc/chef/
mkdir -p /tmp/chef-solo/
cd /chef-repo/cookbooks
yum -y install git
git clone git://github.com/kakakikikeke/cookbooks-emacs.git
```

```
cat << EOF > /chef-repo/cookbooks/cookbooks-emacs.json
{
  "run_list": [
    "recipe[cookbooks-emacs]"
  ]
}
EOF
```

```
cat << EOF > /etc/chef/client.rb
  file_cache_path "/tmp/chef-solo"
  cookbook_path ["/chef-repo/cookbooks"]
  role_path "/chef-repo/roles"
  log_level :debug
EOF
```

* Execute chef-solo

```
chef-solo -j cookbooks-emacs.json
```

After installed, you can use emacs.

```
/usr/local/bin/emacs
```
