
header_has_class= (cls)->
  (path, window, res) ->
    window.$(".#{cls}").size() > 0

encoding_is= ->
  (path, window, res) ->
    true

hasPath= (str)->
  (path) ->
    path.indexOf(str) > -1

module.exports = (yiai) ->

  yiai.initConfig
    dest:     "./dest"
    origin:   "http://localhost:8098"
    filelist: "filelist.txt"
    patterns: 

      patternA:
        check:   [header_has_class('logo'), encoding_is('utf-8')]
        replace:
          '#CONTAINER p': (str, $) ->
            str.replace 'png', 'hogehogehogehoge'

      patternB:
        check:   [header_has_class('mainNav'), encoding_is('utf-8')]
        replace:
          '#container p:eq(1)': (str)-> str.replace "d", "a"
          '#container p:eq(0)': (str)-> "----------"

      patternC:
        check:   [hasPath("/users"), encoding_is('utf-8')]
        replace:
          '#container p:eq(1)': (str)-> str.replace "d", "a"
          '#container p:eq(0)': (str)-> "----------"
