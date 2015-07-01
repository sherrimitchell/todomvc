class ListsController < ActionController::Base
 before_action :authenticate_user!

 def index
 	page = params[:page] || 1
    @lists = List.order(written_at: :desc).page(page).per(5)
    render :index
 end

 def new
 	@lists = current_user.list.new
 	render :new
 end

 def create
 	@list = current_user.list.create( :user_id params :user_id, 
							 		:list_name params[:list_name], 
							 		:created_at params[:created_at])
 	redirect_to user_lists_path(@list)
 end

 def show
 	@lists = current_user.lists.find_by(:list_id params[:list_name])
 	render :show
 end

 def edit
 	@list = current_user.list.find_by(:list_id params[:list_id])
 	render :edit
 end

 def update
 	@list = List.find(params[:id])
    if @list.user. == current_user
      @list.update(list_name: params[:list_name], updated_at: params[:params])
    else
      flash[:alert] = 'Only the author of a list may edit a list.'
    end
    redirect_to user_list_path(@list)
 end

 def delete
 	@list = List.find_by(params[:id])
 	if @list.user = current_user
 		@list.delete
 	else
 		flash[:alert] = 'Only the author of a list may delete a list.'
 	end
 end
end
