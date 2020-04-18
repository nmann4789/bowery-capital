/* global $ */
const _helpers = require('./_helpers')
const _continuousScrollFeed = {
  settings: {
    cardsToLoad: 12,
    startingLength: 0,
    isLoading: false
  },
  handleFilterSelect: function () {
    $('.feed-filter').on('change', function (e) {
      e.preventDefault()
      let $searchValue = $('#search-box').val()
      let $topicDropdown = $('#topicDropdown').val()
      let queryString = _continuousScrollFeed.buildQueryString($searchValue, $topicDropdown)
      let currentChannel = _helpers.getUrlSegment(1)
      window.location.href = window.location.origin + '/' + currentChannel + queryString + '#category-filter'
    })
  },
  setToggleValues: function () {
    let search = this.getParameterByName('search')
    let topic = this.getParameterByName('topic')

    //TODO Set Active Toggle
    if ($('.category-toggle').length > 0) {
      $('.category-toggle a.' + topic).addClass('active')
      if (search !== null || topic !== null) {
        $('.clear-filter').addClass('active')
      }
    }
  },
  calculateLoadMore: function () {
    let $resourceContainerOffsetTop = $('.continuous-scroll').offset().top
    let $resourceContainerHeight = $('.continuous-scroll').height()
    let $scrollDistance = $(window).scrollTop()
    let $windowHeight = window.innerHeight
    let $loadBuffer = 300
    if (($resourceContainerOffsetTop + $resourceContainerHeight) < ($scrollDistance + $windowHeight + $loadBuffer) && !_continuousScrollFeed.settings.isLoading) {
      $('.loading-spinner').show()
      _continuousScrollFeed.settings.isLoading = true
      let url = $('#load-more-cards').attr('href')
      _continuousScrollFeed.makeAjaxRequest(url)
      _continuousScrollFeed.updateLoadMoreUrl(url)
    }
  },
  loadMoreCards: function () {
    _continuousScrollFeed.startingLength = $('.continuous-scroll .card-container').length
    $(document).scroll(function () {
      if (_continuousScrollFeed.startingLength >= 12) {
        _continuousScrollFeed.calculateLoadMore()
      }
    })
  },
  getParameterByName: function (name, url) {
    if (!url) url = window.location.href
    name = name.replace(/[[\]]/g, '\\$&')
    let regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)')
    let results = regex.exec(url)
    if (!results) return null
    if (!results[2]) return ''
    return decodeURIComponent(results[2].replace(/\+/g, ' '))
  },
  makeAjaxRequest: function (url) {
    $.ajax({
      url: url,
      type: 'GET',
      dataType: 'html',
      success: function (returnData) {
        let $lengthBefore = $('.continuous-scroll .card-container').length
        $('.continuous-scroll').append(returnData)
        let $lengthAfter = $('.continuous-scroll .card-container').length
        // console.log("Number of New Cards: "+($lengthAfter-$lengthBefore));
        if (($lengthAfter - $lengthBefore) === 12) {
          // console.log("Setting loading false")
          _continuousScrollFeed.settings.isLoading = false
        } else if (($lengthAfter - $lengthBefore) < 12) {
          // console.log("hiding spinner")
          $('.loading-spinner').hide()
        }
      }
    })
  },
  buildQueryString: function (search, topic) {
    // console.log('search: ' + search + ', type: ' + type + ', topic: ' + topic)
    //TODO Validate Working
    let queryString = ''
    if (topic === null) {
      queryString = ''
    } else {
      queryString = '?topic=' + topic
    }

    if (search !== '' && search !== null) {
      queryString = queryString + '&search=' + search
    }

    return queryString
  },
  parseResourceParams: function () {
    let search = this.getParameterByName('search')
    let topic = this.getParameterByName('topic')

    return _continuousScrollFeed.buildQueryString(search, topic)
  },
  updateLoadMoreUrl: function (url) {
    // console.log("Old Url: "+url)
    let http = url.split('://')[0]
    let relPath = url.split('://').pop()
    let segments = relPath.split('/')
    segments.splice(-1, 1)
    let offset = parseInt(relPath.split('/').splice(-1, 1))
    let newOffset = offset + _continuousScrollFeed.settings.cardsToLoad

    let queryString = this.parseResourceParams()
    let newUrl = http + '://' + segments.join('/') + '/' + newOffset + queryString
    console.log("New URL: "+newUrl);
    $('#load-more-cards').attr('href', newUrl)
  },
  cardSlideAnimation: function (element, delay) {
    setTimeout(function () {
      $(element).removeClass('card__loading').addClass('card__loaded')
    }, delay)
  },
  init: function () {
    if ($('.continuous-scroll').length > 0) {
      _continuousScrollFeed.loadMoreCards()
    }
    if ($('#category-filter').length > 0) {
      _continuousScrollFeed.handleFilterSelect()
      _continuousScrollFeed.setToggleValues()
    }
  }
}

module.exports = _continuousScrollFeed
