'use strict'

c = require("./check")

module.exports = 

  patternA:
    check:   [c.header_has_class('logo'), c.encoding_is('utf-8')]
    replace:
      '#CONTAINER p': (str, $) ->
        str.replace 'png', 'hogehogehogehoge'
  #patternB:
  #  check:   [c.header_has_class('mainNav'), c.encoding_is('utf-8')]
  #  replace:
  #    '#container p:eq(1)': (str)-> str.replace "d", "a"
  #    '#container p:eq(0)': (str)-> "----------"
  #patternC:
  #  check:   [c.hasPath("/report"), c.encoding_is('utf-8')]
  #  replace:
  #    '#container p:eq(1)': (str)-> str.replace "d", "a"
  #    '#container p:eq(0)': (str)-> "----------"
