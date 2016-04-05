class AddTimeStampsToTodoLists < ActiveRecord::Migration
  def change
    add_column :todo_lists, :created_at, :datetime
    add_column :todo_lists, :updated_at, :datetime
  end
end
