class ChangeItemsTableName < ActiveRecord::Migration
  def change
  	change_table :items do |t|
  	t.rename_table :items, :todo_items
  end
end
