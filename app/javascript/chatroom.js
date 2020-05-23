//when typing message, enter key will work as send button
$(document).on('turbolinks:load', function() {
	$('#new_message').keypress(function(e) {
    if (e.keyCode == 13) {
    	e.preventDefault();
        $(this).submit();
    }
	});
//following code is moved to channels/chatrooms_channels.js because App keyword was not working
	// $("#new_message").submit(function(e){
	// 	e.preventDefault();
	// 	chatroom_id = parseInt($("[data-behavior='messages']").attr("data-chatroom-id"))
	// 	message_body = $("#message_body");
	// 	body = message_body.val();
	// 	message_body.val("");	//setting message body empty for new message
	// 	App.send_message(chatroom_id,body);
	// })
});

