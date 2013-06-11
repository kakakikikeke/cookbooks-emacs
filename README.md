cookbooks-emacs
==================

emacs23.4と各種必要な拡張lispをインストールしてくれるcookbooksです

インストールする拡張lisp一覧
----------------------------

* 簡易インストール（デフォルト）の場合
  * キーバインド
  * バックアップの一元管理
  * emacs server設定
  * buffer-listの自動ソート設定
* フルインストールの場合
  * 上記 + jdeなどの開発環境一式
  * http://kakakikikeke.blogspot.com/2013/01/emacs.html

前提条件
--------

* 簡易インストール（デフォルト）の場合
  * make gcc autoconf ncurses-devel がインストールされている（ネットワークが使える環境であれば本cookbooksでインストールすることも可能です）
* フルインストールの場合
  * make gcc autoconf ncurses-devel がインストールされている（ネットワークが使える環境であれば本cookbooksでインストールすることも可能です）
  * Java6.0以上がインストールされている（jde使用のため）
  * JAVA_HOMEが設定されている（jde使用のため）

動作環境
--------

* CentOS 6.4 64bit上での動作は確認しています（RedHat系OS以外では動作しないと思われます）

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
* default['emacs']['home']
  * デフォルトの値は「/root」
  * 後ろに「/」はつけないでください
  * emacsを起動するユーザのホームディレクトリを指定する、基本はこのままで問題なし
* default['emacs']['java']['home']
  * デフォルトの値は「/usr/local/java」
  * 後ろに「/」はつけないでください
  * フルインストール時に設定したJAVA_HOMEをここに記載します
* default['emacs']['path']
  * デフォルトの値は「/usr/local/bin/」
  * emacsをインストールするパス、基本はこのままで問題なし
  * 本cookbooksでインストールするemacs以外を起動スクリプトから起動させたい場合にはそのパスを指定する
* default['emacs']['uid']
  * デフォルトの値は「0（root）」
  * emacs serverを動作させるユーザのidを指定する
* default['emacs']['chkconfig']
  * デフォルトの値は「false」
  * emacs serverをサーバ起動時に自動で立ち上げるためのchkconfigの設定
  * trueにして自動起動させたい場合にはvisudoを実施してttyの設定を変更する必要があります

```
visudo
Defaults    requiretty
↓
#Defaults    requiretty
```

注意事項
--------

* Javaをインストールするのはjdeをインストールするためです（フルインストール後にjdeがひつようなければ.emacsをコメントしてください）
* jdeの読み込みが遅く起動が重いので使用しない場合は.emacsの「1. for jdee」の部分をコメントアウトしてください
* emacsはソースコードからコンパイルしてインストールします
* 拡張lispもすでにcookbooksのfilesにおいてあるので、インターネットにつながらない環境でも実行可能です（簡易インストールする場合の前提条件はクリアしている必要あり）
* java-auto-completeで補完する場合には http://kakakikikeke.blogspot.jp/2013/03/emacsjava.html の 4. に記載の手順で.java_base.tagを作成してください

トラブルシューディング
----------------------

* service コマンド経由でjdeがうまく動作しない
  * すいませんが、emacs --daemonで起動してください
  * おそらくは環境変数の情報がうまく渡ってないのが理由だと思います
* 起動してないのにstartを実行するとうまく動作しない
  * pidファイルがあるので、それを削除してください
  * rm /tmp/emacs${emacsd_uid}/server
