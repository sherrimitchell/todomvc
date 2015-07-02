class ListsController < ActionController::Base
 before_action :authenticate_user!

 def index
 	page = params[:page] || 1
    @lists = self.get(get_page).page
    render :index
 end

 def show
 	@lists = current_user.lists.find_by(list_name: list_name)
 	render :show
 end

 def new
 	@lists = current_user.list.new
 	render :new
 end

 def create
 	items = params[:items]
 	list_items = Item.find_or_create_by[item_name: item]
 	@list = current_user.list.create(list_name: params[:list_name], 
							 		created_at: params[:created_at],
							 		items: list_items)
 	redirect_to user_lists_path(@list)
 end

 def edit
 	@list = current_user.list.find_by(list_name: list_name)
 	render :edit
 end

 def update
 	@list = current_user.list.find_by(list_name: list_name)
    if @list.user == current_user
      @list.update(list_name: params[:list_name], updated_at: params[:updated_at])
    else
      flash[:alert] = 'Only the author of a list may edit a list.'
    end
    redirect_to user_list_path(@list)
 end

 def delete
 	@list = current_user.list.find_by(list_name: list_name)
 	if @list.user = current_user
 		@list.delete
 	else
 		flash[:alert] = 'Only the author of a list may delete a list.'
 	end
 end

 protected
 def get_page(n)
 	page_offset = (n - 1) * 10
 	List.order(created_at: :desc).offset(page_offset).limit(10)
 end
end
