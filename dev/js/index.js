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
  $('.vc_gitem-zone-img').each(function (index, element) {

    // let title = $(this).find('.vc_gitem-zone a').attr('title')
    // let slug = ($(this).find('.vc_gitem-zone a').attr('href')).split('/')[5];
    // let postDate = "skip"
    // let imgThumb = $(this).find('.vc_gitem-zone-img').attr('src')
    // let shortDescription = $(this).find('.vc_gitem-post-data-source-post_excerpt div p').text()
    // let categories = "skip"
    //
    // // $(this).find('.mkd-category-name').each(function(){
    // //   categories += ($(this).text() + "| ")
    // // })
    // console.log(index,"|",title,"|",slug,"|",postDate, "|",imgThumb,"|",categories,"|",shortDescription  )

    var a = document.createElement('a');
    a.href = $(this).attr('src');
    a.download = $(this).attr('src');
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
  })
})

$(window).on('load', function () {

})
