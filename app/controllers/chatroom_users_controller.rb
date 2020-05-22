class ChatroomUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom

  def create
  	@chatroom_user = ChatroomUser.where(chatroom_id: @chatroom.id, user_id: current_user.id).first_or_create
  	redirect_to @chatroom
  end

  def destroy
  		@chatroom_user = ChatroomUser.where(chatroom_id: @chatroom.id, user_id: current_user.id).destroy_all
  	redirect_to chatrooms_path
  end

  private

  def set_chatroom
  	# byebug
  	@chatroom = Chatroom.find(params[:chatroom_id])
  end
end
