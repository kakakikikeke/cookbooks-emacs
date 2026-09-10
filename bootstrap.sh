#!/bin/sh
set -eu

export CHEF_LICENSE=accept

root_path=/tmp/kitchen-run

if ! command -v chef-solo >/dev/null 2>&1; then
  curl -L https://omnitruck.chef.io/install.sh | bash -s -- -P chef
fi

cat > "${root_path}/client.rb" <<'CLIENT_RB'
file_cache_path "/tmp/kitchen/cache"
cookbook_path ["/tmp/cookbooks"]
log_level :info
CLIENT_RB

cat > "${root_path}/cookbooks-emacs.json" <<'JSON'
{
  "run_list": ["recipe[cookbooks-emacs::default]"],
  "owner": "root",
  "group": "root",
  "package": {
    "install": []
  }
}
JSON

chef-solo -c "${root_path}/client.rb" -j "${root_path}/cookbooks-emacs.json"