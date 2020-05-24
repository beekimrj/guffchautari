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

const invite_buttons = document.querySelectorAll("[data-behavior='invite-chatroom-button']");
invite_buttons.forEach(function(currentBtn){
  currentBtn.addEventListener('click',generateInvitationLink);
});

const copy_invite_buttons = document.querySelectorAll("[data-behavior='copy-invite-chatroom-button']");
copy_invite_buttons.forEach(function(currentBtn){
  currentBtn.addEventListener('click',copyToClipboard);
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
	let password_change_status_notifier = $(`#password-change-status-${chatroom_id}`)
	// console.log(password)
	$.ajax({
      url: '/change_chatroom_password',
      type: 'POST',
      data: {chatroom_id: chatroom_id, password: password},
      success: function(res){
      	password_change_status_notifier.text("Successfully Changed").css("color","green").fadeOut(3000);
        password_container.val(res.password)
      },
      error: function(er){
      password_change_status_notifier.text("unsuccessfull").css("color","red").fadeOut(3000);;
      password_container.val(er.responseJSON.password)
      }
    });
}

function generateInvitationLink(){
	let chatroom_id = this.getAttribute("data-chatroom-id");
	let password_container = $(`#chatroom-${chatroom_id}`);
	let password = password_container.val();
	let invitation_container = $(`#invite-chatroom-${chatroom_id}`);
	let base_url = window.location.origin

	let chatroom = {};
	chatroom['id'] = chatroom_id;
	chatroom['password'] = password;
	let params={};
	params['chatroom'] = chatroom;
	let invitation_link = $.param(params);

	invitation_link = `${base_url}/join_chatroom?${invitation_link}`;

	invitation_container.val(invitation_link)
	//enable copy button
	$(`#copy-invite-chatroom-${chatroom_id}`).removeAttr( "disabled" )
}

function copyToClipboard(){
	let chatroom_id = this.getAttribute("data-chatroom-id");
	let copyText = document.getElementById(`invite-chatroom-${chatroom_id}`);
  copyText.select();
  copyText.setSelectionRange(0, 99999)
  document.execCommand("copy");
  // alert("Copied the text: " + copyText.value);
}