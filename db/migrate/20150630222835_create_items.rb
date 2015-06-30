class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :list_id
      t.string :item_name
      t.datetime :due_date
      t.boolean :completed

      t.timestamps null: false
    end
  end
end
