class UpdateFriendshipsTable < ActiveRecord::Migration[6.1]
  def change
    add_reference :friendships, :sent_by, foreign_key: { to_table: :users }
    add_reference :friendships, :sent_to, foreign_key: { to_table: :users }
    add_column :friendships, :status, :boolean, default:false
  end
end
