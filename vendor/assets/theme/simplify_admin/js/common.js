'use strict';

$(document).on('turbolinks:load', function () {
  $('#sidebarToggleLG').click(function () {
    if ($('.wrapper').hasClass('display-right')) {
      $('.wrapper').removeClass('display-right');
      $('.sidebar-right').removeClass('active');
    } else {
      $('.top-nav').toggleClass('sidebar-mini');
      $('aside').toggleClass('sidebar-mini');
      $('footer').toggleClass('sidebar-mini');
      $('.main-container').toggleClass('sidebar-mini');
      $('.main-menu').find('.openable').removeClass('open');
      $('.main-menu').find('.submenu').removeAttr('style');
    }
  });

  $('#sidebarToggleSM').click(function () {
    $('aside').toggleClass('active');
    $('.wrapper').toggleClass('display-left');
  });

  $('.sidebarRight-toggle').click(function () {
    $('.sidebar-right').toggleClass('active');
    $('.wrapper').toggleClass('display-right');
    $('footer').toggleClass('display-right');
    return false;
  });

  $('.sidebar-menu .openable > a').click(function () {
    if (!$('aside').hasClass('sidebar-mini') || Modernizr.mq('(max-width: 991px)')) {
      if ($(this).parent().children('.submenu').is(':hidden')) {
        $(this).parent().siblings().removeClass('open').children('.submenu').slideUp(200);
        $(this).parent().addClass('open').children('.submenu').slideDown(200);
      } else {
        $(this).parent().removeClass('open').children('.submenu').slideUp(200);
      }
    }
    return false;
  });

  if (!$('.sidebar-menu').hasClass('sidebar-mini') || Modernizr.mq('(max-width: 767px)')) {
    $('.openable.open').children('.submenu').slideDown(200);
  }

  return $('#btn-collapse').click(function () {
    $('.sidebar-header').toggleClass('active');
  });
});
