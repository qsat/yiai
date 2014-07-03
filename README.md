yiai
====

## インストール

```
$ git clone https://github.com/qsat/yiai.git
$ cd /your/path
$ npm install
$ bower install
$ cd example
```

## 設定

Yiaifile.coffee/filelist.txt
- スクレイピングしたいURL
- 保存先

を定義

### check.coffeeでチェックするパターンを定義

```
module.exports = 

  hasId: (id) ->
    (path, window, res) ->
      window.$("##{id}").size() > 0
```

### pattern.coffeeでreplaceを定義

```
c = require("./check")

module.exports = 
  taskName:
    check: [c.hasId('header')]
    replace:
      '#header': (str, $) ->
        '差し替えたい文字列をreturnする'
        
# replaceObjectのkeyはjquery selectorになります。
# 上記の例だと$('#header')
```

## 実行
Yiaifile.coffee
があるディレクトリに移動して

```
yiai
```
