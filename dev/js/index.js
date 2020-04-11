/* global $ */
'use strict'
import 'lazysizes'
import 'lazysizes/plugins/blur-up/ls.blur-up'
require('jquery')
require('jquery-modal')
require('slick-carousel')

let _helpers = require('./_helpers')
let _portfolio = require('./_portfolio')

$(document).ready(function () {
  _helpers.init()
  _portfolio.init()
  $('.mkd-blog-holder article').each(function () {

    let title = $(this).find('.mkd-post-title a').text()
    let slug = ($(this).find('.mkd-post-title a').attr('href')).split('/')[5];
    let postDate = $(this).find('.mkd-date').text()
    let imgThumb = $(this).find('.wp-post-image').attr('src')
    let shortDescription = $(this).find('.mkd-post-excerpt').text()
    let categories = ""

    $(this).find('.mkd-category-name').each(function(){
      categories += ($(this).text() + "| ")
    })
    console.log($(this).attr('id'),",",title,",",slug,",",postDate, ",",imgThumb,",",categories,",",shortDescription  )
  })
})

$(window).on('load', function () {

})
