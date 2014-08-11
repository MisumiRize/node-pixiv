(function() {
  var columns, csv, next, params, ranking, request, search, talk, _;

  request = require('request');

  csv = require('csv');

  _ = require('lodash');

  params = {
    PHPSESSID: 0,
    p: 1
  };

  columns = ['illust_id', 'user_id', 'extension', 'title', 'server_number', 'user_fullname', 'illust_128_url', 'x1', 'x2', 'illust_480mw_url', 'x3', 'x4', 'created_at', 'tags', 'tool', 'evaluations', 'evaluation_point', 'views', 'caption', 'pages', 'x5', 'x6', 'x7', 'x8', 'user_name', 'x9', 'r18', 'x10', 'x11', 'avatar_url'];

  search = function(options, cb) {
    var qs;
    qs = {
      s_mode: 's_tag',
      order: 'date'
    };
    if (typeof options === 'string' || options instanceof String) {
      options = {
        word: options
      };
    }
    return talk('http://spapi.pixiv.net/iphone/search.php', _.extend(qs, options), cb);
  };

  ranking = function(options, cb) {
    if (typeof options === 'string' || options instanceof String) {
      options = {
        mode: options
      };
    }
    return talk('http://spapi.pixiv.net/iphone/ranking.php', options, cb);
  };

  talk = function(url, options, cb) {
    var parser, qs, records;
    parser = csv.parse({
      columns: columns
    });
    records = [];
    qs = _.extend(_.clone(params), options);
    parser.on('readable', function() {
      var record, _results;
      _results = [];
      while (record = parser.read()) {
        _results.push(records.push(record));
      }
      return _results;
    });
    parser.on('end', function() {
      return cb(records, qs);
    });
    return request.get({
      url: url,
      qs: qs
    }).pipe(parser);
  };

  next = function(qs) {
    next = _.clone(qs);
    next.p += 1;
    return next;
  };

  module.exports = {
    search: search,
    ranking: ranking,
    next: next
  };

}).call(this);
