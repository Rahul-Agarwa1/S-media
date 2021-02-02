class CreateUserdetails < ActiveRecord::Migration[6.1]
  def change
    create_table :userdetails do |t|
      t.string :address
      t.string :designation
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
