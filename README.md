cookbooks-emacs
==================

emacs23.4と各種必要な拡張lispをインストールしてくれるcookbooksです

インストールする拡張lisp一覧
----------------------------

* 一覧  
http://kakakikikeke.blogspot.com/2013/01/emacs.html

前提条件
--------

* 簡易インストール（デフォルト）の場合
  * make gcc autoconf ncurses-devel がインストールされている（ネットワークが使える環境であれば本cookbooksでインストールすることも可能です）
* フルインストールの場合
  * Java6.0以上がインストールされている（jde使用のため）
  * JAVA_HOMEが設定されている（jde使用のため）

動作環境
--------

* CentOS 6.4 64bit上での動作は確認しています

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
  * デフォルトの値は「/root/」
  * .emacsと.emacs.dを設置するディレクトリ
* default['emacs']['tar_save_dir']
  * デフォルトの値は「/tmp/」
  * tarを展開していインストールするため展開先のディレクトリを指定する
* default['emacs']['install']['full']
  * デフォルトの値は「false」
  * jdeやflymakeなどJavaの開発環境も含めたフルインストールをする場合はtrueにする
  * キーバインド等の最小限の設定のみでいいならばfalseにする
* default['network']
  * デフォルトの値は「true」
  * インターネットに接続できる環境があればtrueにする（必要なパッケージのyumインストールを実施できます）

注意事項
--------

* Javaをインストールするのはjdeをインストールするためです（フルインストール後にjdeがひつようなければ.emacsをコメントしてください）
* jdeの読み込みが遅く起動が重いので使用しない場合は.emacsの「1. for jdee」の部分をコメントアウトしてください
* emacsはソースコードからコンパイルしてインストールします
* 拡張lispもすでにcookbooksのfilesにおいてあるので、インターネットにつながらない環境でも実行可能です（簡易インストールする場合の前提条件はクリアしている必要あり）
