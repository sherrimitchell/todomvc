class ChangeListTableName < ActiveRecord::Migration
  def change
  	change_table :lists do |t|
  	t.rename_table :lists, :todo_lists
  end
end
