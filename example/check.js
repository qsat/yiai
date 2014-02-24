// Generated by CoffeeScript 1.7.1
(function() {
  'use strict';
  module.exports = {
    header_has_class: function(cls) {
      return function(path, window, res) {
        return window.$("." + cls).size() > 0;
      };
    },
    encoding_is: function() {
      return function(path, window, res) {
        return true;
      };
    },
    hasPath: function(str) {
      return function(path) {
        return path.indexOf(str) > -1;
      };
    }
  };

}).call(this);