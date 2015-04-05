Promise = require 'bluebird'
request = require 'superagent'
csvParse = require 'csv-parse'
merge = require 'lodash/object/merge'

COLUMNS = [
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
  'x12',
]

search = (word, params = {}) ->
  params = merge
      s_mode: 's_tag'
      order: 'date'
      word: word
    , params
  talk 'http://spapi.pixiv.net/iphone/search.php', params

ranking = (mode, params = {}) ->
  params = merge
      mode: mode
    , params
  talk 'http://spapi.pixiv.net/iphone/ranking.php', params

talk = (url, params) ->
  query = merge
      PHPSESSID: 0
      p: 1
    , params
  new Promise (resolve, reject) ->
      request
        .get url
        .query query
        .end (err, res) ->
          if err then reject err else resolve res
    .then parse

parse = (res) ->
  new Promise (resolve, reject) ->
    csvParse res.text, columns: COLUMNS, (err, data) ->
      if err then reject err else resolve data

module.exports =
  search: search
  ranking: ranking
