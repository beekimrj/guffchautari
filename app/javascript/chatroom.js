//when typing message, enter key will work as send button
$(document).on('turbolinks:load', function() {
	$('#new_message').keypress(function(e) {
    if (e.keyCode == 13) {
    	e.preventDefault();
        $(this).submit();
    }
	});
});
