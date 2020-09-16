/* global $ */
let _helpers = require('./_helpers')
const _portfolio = {
  settings: {

  },
  controlPortolioPopouts: function () {
    $('.card__portfolio--popout--close').on('click', function () {
      $(this).closest('.card__portfolio--popout').removeClass('active')
    })
    $('.card__portfolio--preview').on('click', function () {
      $('.card__portfolio--popout').removeClass('active')
      $(this).closest('.card__portfolio').find('.card__portfolio--popout').addClass('active')
    })
  },
  initCategoryFilter: function () {
    let initialCookie = _helpers.getCookie('portfolioFilter') === null ? '' : _helpers.getCookie('portfolioFilter')
    if (initialCookie === '') {
      $('.category__filter').eq(0).addClass('selected')
    }
    $('.category__filter').on('click', function (event) {
      event.preventDefault()
      $(this).toggleClass('selected')
      let currentValue = $(this).attr('data-category')
      console.log(currentValue)
      if (currentValue === '') {
        $('.category__filter').removeClass('selected')
        $(this).addClass('selected')
        $('.pos-adjusted').appendTo('.card__portfolio--row')
      } else {
        if ($('.category__filter.selected').length >= 1) {
          $('.category__filter').eq(0).removeClass('selected')
          console.log($('.category__filter.selected').length)
          $('.pos-adjusted').appendTo('.card__portfolio--container.hidden')
          $('.category__filter.selected').each(function (index, element) {
            let category = $(element).attr('data-category')
            $('.card__portfolio--container.hidden .card__portfolio').each(function (index, element2) {
              let cardCats = $(element2).attr('data-filters')
              if (cardCats && cardCats.includes(category)) {
                $(element2).closest('.pos-adjusted').appendTo('.card__portfolio--row')
              }
            })
          })
        } else {
          console.log('no filters')
          console.log($('.category__filter.selected').length)
          $('.category__filter').eq(0).addClass('selected')
          $('.pos-adjusted').appendTo('.card__portfolio--row')
        }
      }
    })
  },
  init: function () {
    _portfolio.initCategoryFilter()
    _portfolio.controlPortolioPopouts()
  }
}

module.exports = _portfolio
