/* global $ */
'use strict'
import 'lazysizes'
import 'lazysizes/plugins/blur-up/ls.blur-up'
require('jquery')
require('jquery-modal')
require('slick-carousel')

let _helpers = require('./_helpers')
let _portfolio = require('./_portfolio')
let _team = require('./_team')
let _continuousScroll = require('./_continuousScroll')

$(document).ready(function () {
  _helpers.init()
  _portfolio.init()
  _team.init()
  _continuousScroll.init()
})

$(window).on('load', function () {

})
