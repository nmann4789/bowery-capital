/* global $ */
const _portfolio = {
  settings: {

  },
  addPopoutHandler: function(popout){
    console.log('adding click handler')
    popout.on('click', function(){
      console.log('opening popout')
      $('.card__portfolio--popout').removeClass('active')
      $(this).find('.card__portfolio--popout').addClass('active')
      $(this).off()
    })
  },
  controlPortolioPopouts: function(){
    $('.card__portfolio--popout--close').on('click', function(){
      console.log('closing popout')
      $(this).closest('.card__portfolio--popout').removeClass('active')
      _portfolio.addPopoutHandler($(this).closest('.card__portfolio'))
    })
    $('.card__portfolio').each(function(){
      _portfolio.addPopoutHandler($(this))
    })
  },
  init: function () {
    _portfolio.controlPortolioPopouts()
  }
}

module.exports = _portfolio
