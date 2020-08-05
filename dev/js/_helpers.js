/* global $ */
const _helpers = {
  settings: {

  },
  loadjscssfile: function (filename, filetype) {
    let fileref = ''
    if (filetype === 'jsonp') {
      fileref = document.createElement('script')
      fileref.setAttribute('src', filename)
    } else if (filetype === 'js') { // if filename is a external JavaScript file
      fileref = document.createElement('script')
      fileref.setAttribute('type', 'text/javascript')
      fileref.setAttribute('src', filename)
    } else if (filetype === 'css') { // if filename is an external CSS file
      fileref = document.createElement('link')
      fileref.setAttribute('rel', 'stylesheet')
      fileref.setAttribute('type', 'text/css')
      fileref.setAttribute('href', filename)
    }
    if (typeof fileref !== 'undefined') { document.getElementsByTagName('head')[0].appendChild(fileref) }
  },
  isMobileDevice: function () {
    return (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i).test(navigator.userAgent)
  },
  playWistiaVideo: function (videoId) {
    window._wq = (window._wq || [])
    window._wq.push({
      id: videoId,
      options: { autoPlay: true, muted: true },
      onReady: function (video) {
        video.play()
      }
    })
  },
  createCookie: function (name, value, minutes, path) {
    let expires = ''
    if (minutes) {
      let date = new Date()
      date.setTime(date.getTime() + (minutes * 60 * 1000))
      expires = '; expires=' + date.toGMTString()
    } else {
      expires = ''
    }
    document.cookie = name + '=' + value + expires + '; path=' + path
  },
  getCookie: function (name) {
    let dc = document.cookie
    let prefix = (name) + '='
    let begin = dc.indexOf('; ' + prefix)
    let end = 0
    if (begin === -1) {
      begin = dc.indexOf(prefix)
      if (begin !== 0) return null
    } else {
      begin += 2
      end = document.cookie.indexOf(';', begin)
      if (end === -1) {
        end = dc.length
      }
    }

    return decodeURI(dc.substring(begin + prefix.length, end))
  },
  getParameterByName: function (name) {
    name = name.replace(/[[]/, '\\[').replace(/[\]]/, '\\]')
    let regex = new RegExp('[\\?&]' + name + '=([^&#]*)')
    let results = regex.exec(window.location.search)
    return (results === null) ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '))
  },
  getUrlSegment: function (index) {
    let pathArray = window.location.pathname.split('/')
    return pathArray[index]
  },
  scrollToDiv: function () {
    $('.scroll-to-div').on('click', function (e) {
      e.preventDefault()
      let destination = $(this).attr('href')
      $('html,body').animate({ scrollTop: $(destination).offset().top }, 'slow')
    })
  },
  scrollToElement: function (element) {
    $('html,body').animate({ scrollTop: $(element).offset().top }, 'slow')
  },
  addArrowToLinks: function () {
    $('.arrow-on-hover').hover(function () {
      $(this).addClass('color-orange arrow')
    },
    function () {
      $(this).removeClass('color-orange arrow')
    })
  },
  init: function () {
    this.scrollToDiv()
  }
}

module.exports = _helpers
