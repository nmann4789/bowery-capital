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
    $(document).mouseup(function (e) {
      var container = $('.card__team--popout--content')

      // if the target of the click isn't the container nor a descendant of the container
      if (!container.is(e.target) && container.has(e.target).length === 0) {
        $(e.target).closest('.card__team--popout').removeClass('active')
      }
    })
  },
  init: function () {
    _team.controlTeamPopouts()
  }
}

module.exports = _team
