$(document).ready(function() {

  $("a.fancybox").fancybox({
    type: 'iframe',
    autoSize: false,
    overlayOpacity: .5,
    overlayColor: '#f64',
    transitionIn: 'elastic',
    transitionOut: 'elastic',
    easingOut: 'easeOutSine',
    cyclic: true,
  });

});
