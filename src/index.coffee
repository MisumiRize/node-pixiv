request = require 'request'
csv = require 'csv'

search = (word, cb) ->
  csv().from(
    request.get({
      url: 'http://spapi.pixiv.net/iphone/search.php',
      qs: {
        s_mode: 's_tag'
        word: word
        order: 'date'
        PHPSESSID: 0
        p: 1
      }
    })
  ).to.array cb

module.exports.search = search
