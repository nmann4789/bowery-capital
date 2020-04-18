/* global $ */
const _team = {
  settings: {

  },
  controlTeamPopouts: function () {
    $('.card__team--popout--close').on('click', function () {
      $(this).closest('.card__team--popout').removeClass('active')
    })
    $('.card__team--preview').on('click', function () {
      $('.card__team--popout').removeClass('active')
      $(this).closest('.card__team').find('.card__team--popout').addClass('active')
    })
  },
  init: function () {
    _team.controlTeamPopouts()
  }
}

module.exports = _team
