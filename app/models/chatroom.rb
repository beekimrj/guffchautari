class Chatroom < ApplicationRecord
  belongs_to :user
  
  has_many :chatroom_users
	has_many :users, through: :chatroom_users
  has_many :messages

end
