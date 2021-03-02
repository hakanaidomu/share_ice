$(function() {
  $('.slider').slick({
      centerMode: true,
      centerPadding: '10%',
      dots: true, //スライドの下にドットのナビゲーションを表示
      autoplay: true, //自動再生
      autoplaySpeed: 2000, //再生スピード
      infinite: true
  });
});