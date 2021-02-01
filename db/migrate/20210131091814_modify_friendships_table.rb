class ModifyFriendshipsTable < ActiveRecord::Migration[6.1]
  def change
    remove_reference :friendships, :friend
    remove_reference :friendships, :user
    
  end
end
