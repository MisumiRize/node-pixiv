request = require 'request'
csv = require 'csv'
_ = require 'lodash'

params =
  PHPSESSID: 0
  p: 1

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
  qs =
    s_mode: 's_tag'
    order: 'date'
  options = word: options if _.isString options
  talk 'http://spapi.pixiv.net/iphone/search.php', _.extend(qs, options), cb

ranking = (options, cb) ->
  options = mode: options if _.isString options
  talk 'http://spapi.pixiv.net/iphone/ranking.php', options, cb

talk = (url, options, cb) ->
  parser = csv.parse columns: columns
  records = []
  qs = _.extend _.clone(params), options
  parser.on 'readable', ->
    while record = parser.read()
      records.push record
  parser.on 'end', ->
    cb records, qs
  request.get url: url, qs: qs
    .pipe parser

next = (qs) ->
  next = _.clone qs
  next.p += 1
  next

module.exports = {
  search: search
  ranking: ranking
  next: next
}
