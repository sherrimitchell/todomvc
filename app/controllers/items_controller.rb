class ItemsController < ActionController::Base
  before_action :authenticate_user!

 def new
 	render :new
 end

 def create
 	@item = @list.item.create( :item_id params :item_id, 
							 		:list_id params[:list_id],
							 		:item_name params[:item_name],
							 		:due_date params[:due_date],
							 		:completed params[:completed]
							 		:created_at params[:created_at])
 end

 def edit
 	@item = @list.item.find_by(:item_id params[:item_id])
 	render :edit
 end

 def update
 	@item = Item.find(params[:id])
 	@item.update(item_name: params[:item_name], :due_date params[:due_date], updated_at: params[:updated_at])
 end

 def delete
 	@item = item.find_by(params[:id])
 	if @item.user = current_user
 		@item.delete
 	else
 		flash[:alert] = 'Only the author of an item may delete a item.'
 	end
 end
end
