pixiv = require '../src/index'
request = require 'request'
stub = null

describe 'search', ->
  before ->
    stub = sinon.stub request, 'get'

  after ->
    stub.restore()

  it 'should invoke callback function with CSV data and GET parameters', ->
    stub.returns fs.createReadStream("#{__dirname}/search.csv")
    pixiv.search 'search word', (data, params) ->
      expect(data[0].extension).to.be.equal 'success'
      expect(params.p).to.be.equal 1
      expect(params.word).to.be.equal 'search word'

describe 'next', ->
  it 'should return params for next page but should not break given params', ->
    previous = {p: 1}
    next = pixiv.next previous
    expect(previous.p).to.be.equal 1
    expect(next.p).to.be.equal 2
