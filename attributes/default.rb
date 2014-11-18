# -*- coding: utf-8 -*-
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
