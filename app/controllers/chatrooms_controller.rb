class ChatroomsController < ApplicationController

	before_action :authenticate_user!

  def index
  	@chatrooms = ChatroomUser.where(user_id:current_user.id)
		@owned_chatrooms = Chatroom.where(user_id: current_user.id)
		@chatroom = Chatroom.new;
  end

  def join
  	chatroom_id = chatroom_params[:id]
  	password = chatroom_params[:password]
  	@chatroom = Chatroom.where(id: chatroom_id).first
  	if @chatroom.present?
  		if @chatroom.password == password || @chatroom.user_id == current_user.id
    		ChatroomUser.where(chatroom_id: @chatroom.id, user_id: current_user.id).first_or_create
  			flash.notice ="Welcome to #{@chatroom.name}"
  			# byebug
  			# redirect_to chatrooms_path(@chatroom) and return
  			 redirect_to chatroom_path(@chatroom) and return
  		end
  	end
  		flash.alert = "Chatroom or password incorrect"
  		redirect_to chatrooms_path
  end

  def create
  	@chatroom = Chatroom.new(chatroom_params)
  	@chatroom['user_id'] = current_user.id

    if(@chatroom.save )
    	ChatroomUser.where(chatroom_id: @chatroom.id, user_id: current_user.id).first_or_create
      redirect_to chatrooms_path
    else
    	render 'new'
    end
  end

	def show
		@chatroom = Chatroom.where(id: params[:id])
		if @chatroom.present?
			@chatroom=@chatroom.first
			@messages=@chatroom.messages.order(created_at: :desc).limit(100).reverse
			@members = @chatroom.users
			@chatroom_creator_id=@chatroom.user_id
		else
			flash.alert = "Chatroom might have been delete by your friend"
			redirect_to chatrooms_path
		end
	end


	def change_chatroom_password
		@chatroom = Chatroom.find(params[:chatroom_id])
		password = params[:password]
		chatroom_creator_id = @chatroom.user_id
		if chatroom_creator_id == current_user.id
			if @chatroom.update(password: password)
				render json: {password: password}
			else
				password = @chatroom.password
				render json: {password: password}, status: :unprocessable_entity
			end
		else
			render json: {password: password}, status: :unprocessable_entity
		end
	end

	def destroy
		@chatroom = Chatroom.find(params[:id])
		@chatroom.destroy 

		redirect_to chatrooms_path
	end


	def update
		@chatroom = Chatroom.find(params[:id])
		if(@chatroom.update(chatroom_params) )
			redirect_to @chatroom
		else
			render 'edit'
		end
	end

	private

	def chatroom_params
	params.require(:chatroom).permit(:name, :password, :user_id, :id)
	end
  			
 
end
