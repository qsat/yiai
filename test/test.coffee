# mocha test.coffee --compilers coffee:coffee-script/register -R spec -w

require 'coffee-script/register'

fs = require 'fs'
nock = require 'nock'
expect = require 'expect.js'

Yiai = require "../lib/yiai"
yiai = new Yiai

require( "./Yiaifile" )( yiai )

describe "_reqdfile ディレクトリ名の場合に、index.htmlを付与する", ->

  it "/ で終わる(ディレクトリ)の場合は、index.htmlを付与した文字列を返す", ->
    expect( yiai._reqfile "/" ).to.be "/index.html"
    expect( yiai._reqfile "/user/" ).to.be "/user/index.html"
    expect( yiai._reqfile "/user" ).to.be "/user/index.html"
    expect( yiai._reqfile "user" ).to.be "user/index.html"

  it 'パスにファイル名が含まれていれば、そのまま返す', ->
    expect( yiai._reqfile "/index.html" ).to.be "/index.html"
    expect( yiai._reqfile "/user/index.html" ).to.be "/user/index.html"


describe "_dirname ディレクトリ名を返す", ->

  it "パスが不完全なときは、/を付与する", ->
    expect( yiai._dirname "user/list/" ).to.be "user/list/"
    expect( yiai._dirname "/user/list" ).to.be "/user/list/"
    expect( yiai._dirname "user/list" ).to.be "user/list/"

  it "パスに拡張子があればディレクトリ名を返す", ->
    expect( yiai._dirname "/user_list/index.html" ).to.be "/user_list/"

describe "_lineBy ファイルを読み込んで、改行で分割した配列を返す", ->

  it "改行で分割", ->
    expect( yiai._lineBy("filelist.txt").length ).to.be 2

describe "process", ->

  str = fs.readFileSync './test.html', "utf-8"

  before ->

    #console.log str

    nock('http://localhost:8098')
      .get '/'
      .reply 200, str
      .get '/users/signup/'
      .reply 200, str
    
    yiai.process( dry: false )

  after ->

  it "動作チェック", ->
  
  it "checkメソッド", ->
    path = "/users"
    ret = yiai.check path, {$: -> {size: -> 0}}, str
    expect( ret ).to.contain 'patternC'


