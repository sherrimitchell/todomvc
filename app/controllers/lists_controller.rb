class ListsController < ActionController::Base
 before_action :authenticate_user!, only: [:create, :update, :delete]

 def index
 	@user = User.find_by(id: params[:user_id])
  page = params[:page] || 1
  if @user == current_user
    @todo_lists = Todo_list.order(created_at: :desc).page(page).per(5)
    render :index
    end
  end
 

 def show
 	@todo_lists = Todo_list.find(params[:id])
 	render :show
 end

 def new
 	if @user == current_user
  @todo_list = Todo_list.new
 	render :new
 end

 def create
  @todo_list = current_user.todo_lists.create(list_params)
    if @todo_lists.save
      respond_to do |format|
      format.html { redirect_to todo_list_path(@todo_list) }
      format.js { render :create }
    end
  end	
 end

 def edit
 	@todo_list = todo_list.find_by(list_name: list_name)
 	render :edit
 end

 def update
  if @user == current_user
    @todo_list.update(list_params)
    else
      flash[:alert] = 'Only the author of a list may edit a list.'
    end
    redirect_to list_item_path(@list)
 end

 def delete
 	@list = List.find_by(list_name: list_name )
 	if @list.user = current_user
 		@list.delete
 	else
 		flash[:alert] = 'Only the author of a list may delete a list.'
 	end
 end

 private
 def list_params
  params.require[:todo_list].permit(:title)
end
 end

end
