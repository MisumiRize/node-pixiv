pixiv = require '../src/index'
request = require 'request'
mock = null

before ->
  mock = sinon.mock request

after ->
  mock.restore()

describe 'search', ->
  it 'should invoke callback function with CSV data and GET parameters', ->
    mock.expects('get')
    .withExactArgs({
      url: 'http://spapi.pixiv.net/iphone/search.php'
      qs: {
        s_mode: 's_tag'
        order: 'date'
        PHPSESSID: 0
        p: 1
        word: 'search word'
      }
    }).returns fs.createReadStream("#{__dirname}/search.csv")
    pixiv.search 'search word', (data, params) ->
      expect(data[0].extension).to.be.equal 'success'

describe 'ranking', ->
  it 'should invoke callback function with CSV data and GET parameters', ->
    mock.expects('get')
    .withExactArgs({
      url: 'http://spapi.pixiv.net/iphone/ranking.php'
      qs: {
        mode: 'day'
        PHPSESSID: 0
        p: 1
      }
    }).returns fs.createReadStream("#{__dirname}/search.csv")
    pixiv.ranking 'day', (data, params) ->
      expect(data[0].extension).to.be.equal 'success'

describe 'next', ->
  it 'should return params for next page but should not break given params', ->
    previous = {p: 1}
    next = pixiv.next previous
    expect(previous.p).to.be.equal 1
    expect(next.p).to.be.equal 2
