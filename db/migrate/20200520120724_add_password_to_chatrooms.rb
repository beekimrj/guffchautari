class AddPasswordToChatrooms < ActiveRecord::Migration[6.0]
  def change
    add_column :chatrooms, :password, :string
  end
end
