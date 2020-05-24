class ChatroomsController < ApplicationController

	before_action :authenticate_user!, except: [:index,:show]

  def index
		@chatrooms = Chatroom.all;
		# @user=current_user;
		@chatroom = Chatroom.new;
  end

  def new
  	@chatroom = Chatroom.new;
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
		@chatroom = Chatroom.find(params[:id])
		@messages=@chatroom.messages.order(created_at: :desc).limit(100).reverse
		@members = @chatroom.users
		@chatroom_creator_id=@chatroom.user_id
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
	params.require(:chatroom).permit(:name, :password, :user_id)
	end
  			
 
end
