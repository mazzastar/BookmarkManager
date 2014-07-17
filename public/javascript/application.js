
// console.log("hello, makers academy");


function animateLinks() {
  $('.link').show(1000);
}


$(function(){
	animateLinks();
});

function showLinkFavouritedNotice(link) {
  var favourited = !!$(link).data("favourited");
  // get the text of the .title element
  // that we find among the children of link
  var name = $(link).find('.title').text();
  var message = favourited ?
                name + " was added to favourites" :
                name + " was removed from favourites";
  var $flash = $("<div></div>").addClass('flash notice').html(message);
  $flash.appendTo('#flash-container');

  window.setTimeout(function() {
    $flash.fadeOut();
  }, 3000); // in milliseconds

}

function addFavouritesHandler() {
  $(".star.solid").click(function(event) {
  	var link = $(this).parent();
  	var favourited = !!$(link).data("favourited");
 	var newOpacity = favourited ? 0 : 1;
 	$(link).data("favourited", !favourited);    
	$(this).animate({opacity: newOpacity}, 1000);
	showLinkFavouritedNotice(link);
  });
}

function prepareNewLinkHandler() {
  $('.add-link').click(function(event) {
    $.get($(this).attr("href"), function(data) {
       if ($('#ajax-form').length == 0){
        console.log("working")
         $("#links-container").prepend("<div id='ajax-form'></div>");
       }
      $("#links-container #ajax-form").html(data);
    });
    event.preventDefault();
  });
}


$(function() {
  addFavouritesHandler();
  prepareNewLinkHandler();
})