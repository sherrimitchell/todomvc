class ChangeListsTable < ActiveRecord::Migration
def change
	change_table :lists do |t|
  	rename_table :lists, :todo_lists
  	end
  end
end
