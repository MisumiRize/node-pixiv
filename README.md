node-pixiv [![Build Status](https://travis-ci.org/MisumiRize/node-pixiv.svg?branch=master)](https://travis-ci.org/MisumiRize/node-pixiv) [![Dependency Status](https://david-dm.org/MisumiRize/node-pixiv.svg)](https://david-dm.org/MisumiRize/node-pixiv)
==========
node-pixiv is Pixiv API client library written in Node.js.

## Requirements

* node.js v0.10+
* superagent
* bluebird
* coffee-script
* csv-parse
* lodash

## Getting started

**Attention: Pixiv 0.1 has breaking changes.** All API got to return Promise.

```bash
$ npm install pixiv --save
```

### Search by tag

```javascript
var pixiv = require('pixiv');

pixiv
  .search('SEARCH WORD')
  .then(function(data) {
    console.log(data);
  });
```

### Ranking

```javascript
pixiv
  .ranking('day')
  .then(function(data) {
    console.log(data);
  });
```

### Paging

```javascript
pixiv
  .search('SEARCH WORD', {p: 2})
  .then(function(data) {
    console.log(data);
  });
```

## Old APIs (~> 0.0.1)

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
