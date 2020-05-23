class Chatroom < ApplicationRecord
  belongs_to :user
  
  has_many :chatroom_users, dependent: :destroy
	has_many :users, through: :chatroom_users
  has_many :messages, dependent: :destroy

  validates_presence_of :name

end
