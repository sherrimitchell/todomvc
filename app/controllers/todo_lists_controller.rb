class TodoListsController < ActionController::Base
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
  @todo_list = current_user.todo_list.new(list_params)
 	render :new
 end

 def create
  @todo_list = current_user.todo_lists.create(list_params)

  respond_to do |format|
    if @todo_lists.save
      format.html { redirect_to todo_list_path(@todo_list) }
    else
      format.html { render :new }
    end
  end	
 end

 def edit
 	@todo_list = Todo_list.find_by(title: title)
 	render :edit
 end

 def update
  @user = User.find_by(id: params[:user_id])
  if @user == current_user
    @todo_list.update(list_params)
    respond_to do |format|
      format.html { redirect_to todo_list_item_path(@todo_list) }
    end
      flash[:alert] = 'Only the author of a list may edit a list.'
    end
    
 end

 def delete
 	@todo_list = Todo_list.find_by(title: title)
 	if @todo_list.user == current_user
 		@todo_list.destroy
 	else
 		flash[:alert] = 'Only the author of a list may delete a list.'
 	end
  redirect_to todo_list_path(@todo_list)
 end

 private
 def list_params
  params.require[:todo_list].permit(:title)
  end

end
