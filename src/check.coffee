'use strict'

module.exports = 

  header_has_class: (cls)->
    (path, window, res) ->
      window.$(".#{cls}").size() > 0

  encoding_is: ->
    (path, window, res) ->
      true

  hasPath: (str)->
    (path) ->
      path.indexOf(str) > -1
