# cookbooks-emacs
Install emacs by chef cookbooks into MacOS.

## Supported Platform
* MacOS over 10.15.5

## Install
* Install chef-solo command

```
sudo curl -L https://omnitruck.chef.io/install.sh | sudo zsh
chef-solo -v
```

* Deploy cookbooks

```
mkdir -p ~/chef-repo/cookbooks
mkdir -p /tmp/chef-solo/
cd ~/chef-repo/cookbooks
git clone git://github.com/kakakikikeke/cookbooks-emacs.git
```

Change the username and group in attributes/default.rb

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
EOF
```

* Execute chef-solo

```
chef-solo -c ~/chef-repo/client.rb -j cookbooks-emacs.json
```

After installed, you can use emacs.

```
/usr/local/bin/emacs
```
