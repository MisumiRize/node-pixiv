pixiv = require '../src/index'
request = require 'request'
stub = null

describe 'search', ->
  before ->
    stub = sinon.stub request, 'get'

  after ->
    stub.restore()

  it 'should fetch CSV data', ->
    stub.returns fs.createReadStream("#{__dirname}/search.csv")
    pixiv.search 'search word', (data) ->
      expect(data[0][2]).to.be.equal 'success'
