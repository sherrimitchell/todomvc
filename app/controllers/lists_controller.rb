class ListsController < ActionController::Base
 before_action :authenticate_user!

 def index
 	page = params[:page] || 1
    @lists = List.find_by(id: id).order(created_at: :desc)
    render :index
 end

 def show
 	@lists = List.find(params[:id])
 	render :show
 end

 def new
 	@lists = List.new
 	render :new
 end

 def create
 	items = params[:items]
 	@items = Item.find_or_create_by[item_id: params[:item_id]]
 	@list = current_user.lists.create(list_name: params[:list_name], 
							 		created_at: params[:created_at],
							 		items: params[:items])
 	redirect_to list_path(@list)
 end

 def edit
 	@list = List.find_by(list_name: list_name)
 	render :edit
 end

 def update
 	@list = List.find_by(list_name: list_name)
    if @list.user == current_user
      List.update(list_name: params[:list_name], updated_at: params[:updated_at])
    else
      flash[:alert] = 'Only the author of a list may edit a list.'
    end
    redirect_to list_path(@list)
 end

 def delete
 	@list = List.find_by(list_name: list_name )
 	if @list.user = current_user
 		@list.delete
 	else
 		flash[:alert] = 'Only the author of a list may delete a list.'
 	end
 end

end
