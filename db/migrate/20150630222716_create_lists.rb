class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :user_id
      t.string :list_name

      t.timestamps null: false
    end
  end
end
