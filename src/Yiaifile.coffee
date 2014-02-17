'use strict'

pattern = require("./pattern")

module.exports = (yiai) ->

  yiai.initConfig
    dest:     "./dest"
    origin:   "http://localhost:8098"
    filelist: "filelist.txt"
    patterns: pattern
