node-pixiv [![Build Status](https://travis-ci.org/MisumiRize/node-pixiv.svg?branch=master)](https://travis-ci.org/MisumiRize/node-pixiv)
==========
node-pixiv is Pixiv API client library written in Node.js.

## Requirements

* node.js v0.10+
* coffee-script
* request
* node-csv
* lodash

## Getting started

### Search by tag

```javascript
var pixiv = require('pixiv');
pixiv.search('SEARCH WORD', console.log);
```

### Ranking

```javascript
pixiv.ranking('day', console.log);
```

### Paging

```javascript
pixiv.search('SEARCH WORD', function(data, params) {
  pixiv.search(pixiv.next(params), console.log);
});
```

`pixiv.next(params)` returns parameters for next page.
