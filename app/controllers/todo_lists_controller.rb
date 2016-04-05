class TodoListsController < ActionController::Base
 before_action :authenticate_user!
 before_action :set_todo_list, only: [:show, :edit, :update, :destroy]

 def index
  # @user = User.find_by(id: params[:user_id])
  @todo_lists = current_user.todo_lists.order(created_at: :desc).page(params[:page]).per(params[:per])
  # render :index
  end

 def show
 	@todo_lists = TodoList.find_by(id: params[:id])
 end

 def new
  @todo_list = current_user.todo_list.new
 end

 def edit
 end

 def create
  @todo_list = current_user.todo_lists.create(list_params)

  respond_to do |format|
    if @todo_list.save
      format.html { redirect_to "/todo_lists", notice: 'Todo list was successfully created.' }
      format.json { render :show, status: :created, location: @todo_list }
    else
      format.html { render :new }
      format.json { render json: @todo_list.errors, status: :unprocessable_entity }
    end
  end
 end

 def update
  respond_to do |format|
    if @todo_list.update(list_params)
      format.html { redirect_to todo_list_path(@todo_list), notice: 'Todo list was successfully updated.' }
      format.json { render :show, status: :ok, location: @todo_list }
    else
      format.html { render :edit }
      format.json { render json: @todo_list.errors, status: :unprocessable_entity }
      end
     end
  end

 def delete
  @todo_list.destroy

  respond_to do |format|
    format.html { redirect_to todo_lists(@todo_list), notice: 'Todo list was successfully deleted.'}
    format.json {head :no_content }
 	end
 end

 private
 def set_todo_list
  @todo_list = TodoList.find(params[:id])
 end

 def list_params
  params.require(:todo_list).permit(:user_id, :title, :task)
 end

end
