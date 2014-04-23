request = require 'request'
csv = require 'csv'
_ = require 'lodash'

params = {
  s_mode: 's_tag'
  order: 'date'
  PHPSESSID: 0
  p: 1
}

columns = [
  'illust_id',
  'user_id',
  'extension',
  'title',
  'server_number',
  'user_fullname',
  'illust_128_url',
  'x1',
  'x2',
  'illust_480mw_url',
  'x3',
  'x4',
  'created_at',
  'tags',
  'tool',
  'evaluations',
  'evaluation_point',
  'views',
  'caption',
  'pages',
  'x5',
  'x6',
  'x7',
  'x8',
  'user_name',
  'x9',
  'r18',
  'x10',
  'x11',
  'avatar_url',
]

search = (options, cb) ->
  if typeof options == 'string' or options instanceof String
    options = { word: options }
  qs = _.extend _.clone(params), options
  csv().from(
    request.get({
      url: 'http://spapi.pixiv.net/iphone/search.php',
      qs: qs
    })
  ).to.options { columns: columns }
  .to.array (data) -> cb.call @, data, qs,

next = (qs) ->
  next = _.clone qs
  next.p += 1
  next

module.exports = {
  search: search,
  next: next
}
