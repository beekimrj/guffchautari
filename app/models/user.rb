class User < ApplicationRecord

	attr_accessor :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :chatroom_users
  has_many :chatrooms, through: :chatroom_users
  has_many :messages

	def self.find_for_database_authentication warden_conditions
	  conditions = warden_conditions.dup
	  login = conditions.delete(:login)
	  where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.strip.downcase}]).first
	end
end
