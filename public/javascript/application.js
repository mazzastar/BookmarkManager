
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

function prepareRemoteFormsHandler() {
  $('.add-link,  .new-user, .new-session' ).click(function(event) {
    $.get($(this).attr("href"), function(data) {
       if ($('#ajax-form').length == 0){
         $("#links-container").prepend("<div id='ajax-form'></div>");
       }
      $("#links-container #ajax-form").html(data);
      prepareFormHandler();
    });
    event.preventDefault();
    console.log("stopped de");

  });
}

// $(document).ready(function(){
  // $(".button .form_button")
  // prepareFormHandler();
// };


function prepareFormHandler() {
  console.log('Hi')
  var form = $('#links-container #ajax-form form');
  form.submit(function(event) {    
    console.log("fire when ready");
    var addLink = function(data) {
      console.log(data);
      // $('#links').prepend(data);
      $('#links-container').replaceWith(data);
      $('.link').css({display: "list-item"});
    }
    var data = form.serialize();
    $.post(form.attr('action'), data, addLink);
    event.preventDefault();
  })
}


$(function() {
  addFavouritesHandler();
  prepareRemoteFormsHandler();
  prepareFormHandler();

})