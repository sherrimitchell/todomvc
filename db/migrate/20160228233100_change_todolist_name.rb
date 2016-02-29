class ChangeTodolistName < ActiveRecord::Migration
  def change
  	change_table :todo_lists do |t|
	t.rename :list_name, :title
	end
  end
end
