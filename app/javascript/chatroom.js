//when typing message, enter key will work as send button
$(document).on('turbolinks:load', function() {
	$('#new_message').keypress(function(e) {
    if (e.keyCode == 13) {
    	e.preventDefault();
        $(this).submit();
    }
	});

//hide flash notice
$(".alert" ).fadeOut(3000);

const buttons = document.querySelectorAll("[data-behavior='change-password-button']");
buttons.forEach(function(currentBtn){
  currentBtn.addEventListener('click',changePassword);
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

function changePassword(){
	let chatroom_id = this.getAttribute("data-chatroom-id");
	let password_container = $(`#chatroom-${chatroom_id}`);
	let password = password_container.val();
	// console.log(password)
	$.ajax({
      url: '/change_chatroom_password',
      type: 'POST',
      data: {chatroom_id: chatroom_id, password: password},
      success: function(res){
        password_container.val(res.password)
      },
      error: function(er){
       password_container.val(er.responseJSON.password)

      }
    });
}