cookbooks-emacs
==================

Version
-------

* CentOS 6.4 over
* Emacs 24.4

Abstract
--------

CentOS用にemacs24.4と指定した拡張lispをインストールしてくれるcookbooksです

How to Use
----------

### Install

* chefインストール
```
sudo true && curl -L https://www.opscode.com/chef/install.sh | sudo bash
chef-solo -v
```

* cookbooksインストール
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
cat << EOF > /etc/chef/solo.rb
  file_cache_path "/tmp/chef-solo"
  cookbook_path ["/chef-repo/cookbooks"]
  role_path "/chef-repo/roles"
  log_level :debug
EOF
```

* chef-solo実行  
```
chef-solo -j cookbooks-emacs.json
```

インストールが完了すると
```
/usr/local/bin/emacs
```
にインストールされます

Configure
---------

### Attributes

* attributes/default.rb

```ruby
# .emacsファイルを作成するかどうか
default['dot_emacs']['write'] = true
# package.elをインストールするかどうか、default['dot_emacs']['write'] が true でないと有効にならない
default['package']['manage']['install'] = true
# ここで指定したpackageをインストールするかどうか、default['dot_emacs']['write'] が true で default['package']['manage']['install'] も true でないと有効にならない
# 指定できるパッケージはgnu, melpa, marmaladeで公開されているパッケージ
default['package']['install'] = [
  "anything",
  "auto-complete",
  "markdown-mode",
]

# 実行するユーザのホームディレクトリを指定
default['user']['home'] = "/root"
```

* packageのインストールに関して
package.elの機能を使ってパッケージをインストールします
attributes/default.rbの`default['package']['install']`にインストールしたいパッケージを設定するとインストールすることができます
melpaとmarmaladeからもダウンロードすることができます
存在しないパッケージを指定した場合はchef-soloがエラーとなります

Tips
----

* emacs23をmakeからinstallする方式は廃止しました、タグv1.0を作成しましたので必要な場合はそちらをご利用ください
* emacs23をyumを使ってinstallする方式は廃止しました、タグv2.0を作成しましたので必要な場合はそちらをご利用ください
