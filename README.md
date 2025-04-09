# cookbooks-emacs
Install emacs by chef cookbooks.

## Supported Platform
* Ubuntu 24.04
* chef-solo 18.6.2
* [MacOS](README_mac.md)

## Install
* Install chef-solo command

```
curl -L https://omnitruck.chef.io/install.sh | sudo bash
chef-solo -v
```

* Deploy cookbooks

```
mkdir -p ~/chef-repo/cookbooks
mkdir -p ~/chef-repo/roles
mkdir -p /tmp/chef-solo/
cd ~/chef-repo/cookbooks
git clone https://github.com/kakakikikeke/cookbooks-emacs.git
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
OWNER=kakakikikeke GROUP=kakakikikeke sudo -E chef-solo -l info -L /tmp/cookbooks-emacs.log -c ~/chef-repo/client.rb -j cookbooks-emacs.json
```

After installed, you can use emacs.

```
/usr/local/bin/emacs
```

## Troubleshooting

If an error occurs, please change the permissions of .emacs.d.

```
sudo chown -R kakakikikeke:kakakikikeke ~/.emacs.d
```

If you already have a file in /usr/local/bin/emacs, delete it before running this, otherwise the latest version will not be installed.
