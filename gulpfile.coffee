gulp = require 'gulp'
{coffee, mocha} = do require 'gulp-load-plugins'

gulp.task 'compile', ->
  gulp.src './src/*.coffee'
    .pipe do coffee
    .pipe gulp.dest './lib'

gulp.task 'test', ->
  require './test/helper'
  gulp.src './test/*.test.coffee'
    .pipe do mocha

gulp.task 'default', ['compile', 'test']
