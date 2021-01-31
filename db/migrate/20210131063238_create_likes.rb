class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.integer :likable_id
      t.string :likable_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
