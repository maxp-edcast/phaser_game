var coffee = require('gulp-coffee');
var gulp = require('gulp');
var webpack = require('gulp-webpack');
gulp.task('default', function() {
  return gulp.src('./entry.js')
    .pipe(webpack(require("./webpack.config.js")))
    .pipe(gulp.dest('dist/'));
});
