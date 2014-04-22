request = require 'request'
csv = require 'csv'
extend = require 'extend'

params = {
  s_mode: 's_tag'
  order: 'date'
  PHPSESSID: 0
  p: 1
}

search = (options, cb) ->
  if typeof options == 'string' or options instanceof String
    options = { word: options }
  qs = extend params, options
  csv().from(
    request.get({
      url: 'http://spapi.pixiv.net/iphone/search.php',
      qs: qs
    })
  ).to.array (data) ->
    cb.call @, data, qs

module.exports.search = search
