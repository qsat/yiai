# coffee --watch --compile --output build/ src/
# http://liginc.co.jp/programmer/archives/4848
# http://blog.sarabande.jp/post/52095868617

# node_modules

_ = require 'underscore'
fs = require 'fs'
path = require 'path'
jsdom = require 'jsdom'
async = require 'async'
mkdirp = require 'mkdirp'
colors = require 'colors'
request = require 'request'
jquery = fs.readFileSync "../bower_components/jquery/jquery.min.js", "utf-8"
#jquery = "http://code.jquery.com/jquery.min.js"


class Yiai
  list: {}
  initConfig: (config)->
    {@filelist, @dest, @origin, @patterns} = config

  process: (options) ->
    lines = @_lineBy(@filelist)
    {dry} = options

    tasks = _.map lines, (path, index) =>
      (next) =>
        request uri:"#{@origin}#{path}", (e, res, body)=>
          @log(res.statusCode == 404, "fetch", path)
          @list[path] = { "statusCode": res.statusCode }

          return next(null, index) if res.statusCode == 404

          jsdom.env
            html: body
            src: [jquery]
            done: (error, window) =>
              @list[path].check = matched = @check path, window, res

              unless dry 
                result = @replace matched, window, res
                destpath = "#{@dest}#{path}"
                @_mkdir destpath, "mkdir"
                @_writeFile destpath, result, "write"

              window.close()
              next(null, index)

    async.parallel tasks, (err, results) =>
      console.log results, @list

  check: (path, window, res)->
    _.compact _.map @patterns, (e, i) ->
      i if _.every( _.map e.check, (f, j) -> f path, window, res )

  replace: (matched, window, res) ->
    _.map matched, (e, i) =>
      _.map @patterns[e].replace, (replace, target) ->
        $tar = window.$(target)
        $tar.html replace $tar.html(), window

    window.document.innerHTML

  _lineBy: (filename, encoding="utf-8") ->
    str = fs.readFileSync filename, encoding
    lines = str.split String.fromCharCode(10)
    return _.compact(lines)

  _dirname: (p) ->
    if path.extname(p) isnt ''
      p = path.dirname p
    @_formatDirname p

  _formatDirname: (p) ->
    "#{p}/".replace /\/+/g, "/"

  _reqfile: (p) ->
    if path.extname(p) is ''
      p = "#{@_formatDirname p}index.html"
    p

  _mkdir: (path, cmd) ->
    mkdirp.sync @_dirname(path)
    @log 0, cmd, path

  _writeFile: (path, str, cmd) ->
    path = @_reqfile(path)
    fs.writeFileSync path, str
    @log 0, cmd, path

  log: (error, cmd, path) ->
    stat = if error then "NG".red else "OK".green
    console.log "Yiai " + "#{stat} " + "#{cmd} ".magenta + path

module.exports = Yiai
