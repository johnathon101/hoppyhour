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

  $(".glass.full-menu").click(function(){
    console.log("click");
    $("#sidebar ul").slideToggle("slow",function(){
      $(".glass.empty-menu").css({"display" : "block"});
      $(".glass.full-menu").css({"display" : "none" });
      $("#sidebar ul").css({"display" : "none"});
    })
  })
  $(".glass.empty-menu").click(function(){
    $("#sidebar ul").slideToggle("slow",function(){
      $(".glass.empty-menu").css({"display" : "none"});
      $(".glass.full-menu").css({"display" : "block" });
      $("#sidebar ul").css({"display" : "block"});
  })
})
});
