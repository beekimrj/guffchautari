class ChatroomsController < ApplicationController
  def index
		@chatrooms = Chatroom.all;
		# @user=current_user;
		@chatroom = Chatroom.new;
  end

  def new
  	@chatroom = Chatroom.new;
  end

  def create
  	# byebug
  	@chatroom = Chatroom.new(chatroom_params)
  	@chatroom['user_id'] = current_user.id

    if(@chatroom.save )
      redirect_to chatrooms_path
    else
    	render 'new'
    end
  end

	def show
		@chatroom = Chatroom.find(params[:id])
	end


	def edit
		@chatroom = Chatroom.find(params[:id])
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
