import consumer from "./consumer"

consumer.subscriptions.create("ChatroomsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
  	// console.log(data)
    let active_chatroom = $(`[data-behavior='messages'][data-chatroom-id='${data.chatroom_id}']`);
    if(active_chatroom.length > 0){
      active_chatroom.append(data.message);
    }else{
    $(`[data-behavior='chatroom-link'][data-chatroom-id='${data.chatroom_id}']`).css("font-weight","bold");  
    }
  },
send_message(chatroom_id, body){
    this.perform("send_message", {chatroom_id: chatroom_id, body: body})
  }

});

$(document).on('turbolinks:load', function() {
  $("#new_message").submit(function(e){
    e.preventDefault();
    let chatroom_id = parseInt($("[data-behavior='messages']").attr("data-chatroom-id"))
    let message_body = $("#message_body");
    let body = message_body.val();
    message_body.val(""); //setting message body empty for new message
    consumer.subscriptions["subscriptions"][0].send_message(chatroom_id,body)
  })

});