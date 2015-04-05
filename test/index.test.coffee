{expect} = require 'chai'
pixiv = require '../src/index'

describe 'search', ->
  it 'should return Promise with Array data', ->
    pixiv
      .search 'test'
      .then (data) ->
        expect(Array.isArray(data)).to.be.true

describe 'ranking', ->
  it 'should return Promise with Array data', ->
    pixiv
      .ranking 'day'
      .then (data) ->
        expect(Array.isArray(data)).to.be.true
