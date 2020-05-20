class ChatroomsController < ApplicationController
  def index
		@chatroom = Chatroom.new;
  end
end
