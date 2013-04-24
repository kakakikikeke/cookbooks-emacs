cookbooks-emacs
==================

emacs23.4と各種必要な拡張lispをインストールしてくれるcookbooksです

インストールする拡張lisp一覧
----------------------------

* 一覧  
http://kakakikikeke.blogspot.com/2013/01/emacs.html

前提条件
--------

* Java6.0以上がインストールされている
* JAVA_HOMEが設定されている
* ncurses-devel がインストールされている
* make gcc がインストールされている

インストール手順
----------------

* chefインストール
```
sudo true && curl -L https://www.opscode.com/chef/install.sh | sudo bash
chef-solo -v
```

* cookbooksインストール
```
mkdir -p /chef-repo/cookbooks
mkdir -p /etc/chef/
cd /chef-repo/cookbooks
yum -y install git ncurses-devel make gcc
git clone git://github.com/kakakikikeke/cookbooks-emacs.git
mv cookbooks-emacs emacs
```
```
cat << EOF > /chef-repo/cookbooks/emacs.json
{
  "run_list": [
    "recipe[emacs]"
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
chef-solo -j emacs.json
```
Attributes
----------
* default['emacs']['dir']
  * .emacsと.emacs.dを設置するディレクトリ
* default['emacs']['tar_save_dir']
  * tarを展開していインストールするため展開先のディレクトリを指定する
* default['emacs']['install']['full']
  * jdeやflymakeなどJavaの開発環境もインストールする場合はtrueにする
  * キーバインド等の最小限の設定のみでいいならばfalseにする

注意事項
--------

* w3mは別途 emacs-w3m が必要なためデフォルトでは.emacsがコメントアウトされています
* Javaをインストールするのはjdeをインストールするためです（jdeがひつようなければ.emacsをコメントしてください）
* jdeの読み込みが遅く起動が重いので使用しない場合は.emacsの「1. for jdee」の部分をコメントアウトしてください
* emacsはソースコードからコンパイルしてインストールします
* 拡張lispもすでにcookbooksのfilesにおいてあるので、インターネットにつながらない環境でも実行可能です
