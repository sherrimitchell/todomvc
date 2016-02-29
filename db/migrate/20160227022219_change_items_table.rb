class ChangeItemsTable < ActiveRecord::Migration
	def change
		change_table :items do |t|
		rename_table :items, :todo_items
		end
	end
end
