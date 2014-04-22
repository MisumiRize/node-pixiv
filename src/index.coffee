request = require 'request'
csv = require 'csv'
_ = require 'lodash'

params = {
  s_mode: 's_tag'
  order: 'date'
  PHPSESSID: 0
  p: 1
}

search = (options, cb) ->
  if typeof options == 'string' or options instanceof String
    options = { word: options }
  qs = _.extend _.clone(params), options
  csv().from(
    request.get({
      url: 'http://spapi.pixiv.net/iphone/search.php',
      qs: qs
    })
  ).to.array (data) ->
    cb.call @, data, qs

next = (qs) ->
  next = _.clone qs
  next.p += 1
  next

module.exports = {
  search: search,
  next: next
}
