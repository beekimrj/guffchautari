class ChatroomsChannel < ApplicationCable::Channel
  def subscribed
  	current_user.chatrooms.each do |chatroom|
    stream_from "chatrooms:#{chatroom.id}"
  	end
  end

  def unsubscribed
  	stop_all_streams 
  end

  def send_message(data)
  	Rails.logger.info data
  	@chatroom = Chatroom.find(data["chatroom_id"])
  	message = Message.create(chatroom_id: @chatroom.id,body: data["body"],user: current_user)
  	MessageRelayJob.perform_later(message)
  end
end
