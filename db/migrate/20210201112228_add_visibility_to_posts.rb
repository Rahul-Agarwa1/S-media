class AddVisibilityToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :post_type, :string, default: 'public'
  end
end
