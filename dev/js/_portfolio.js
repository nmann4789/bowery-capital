/* global $ */
const _portfolio = {
  settings: {

  },
  controlPortolioPopouts: function(){
    $('.card__portfolio--popout--close').on('click', function(){
      $(this).closest('.card__portfolio--popout').removeClass('active')
    })
    $('.card__portfolio--preview').on('click', function(){
      $('.card__portfolio--popout').removeClass('active')
      $(this).closest('.card__portfolio').find('.card__portfolio--popout').addClass('active')

    })
  },
  init: function () {
    _portfolio.controlPortolioPopouts()
  }
}

module.exports = _portfolio
