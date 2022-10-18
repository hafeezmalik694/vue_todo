class Api::TodosController < Api::BaseController
  before_action :get_todo, only: [:update, :destroy, :show]
  # skip_before_action :authenticate_request
  def index
    todos = Todo.all
    json_success_response('Listing all Todos', todos)
  end

  def create
    todo = Todo.new(todo_params)
    if todo.save
      json_success_response('Todo Successfully created.', todo)
    else
      json_error_response('Something went wrong', todo.errors.full_messages)
    end
  end

  def show
    json_success_response('Todo Detail', @todo)
  end

  def update
    if @todo.update(todo_params)
      json_success_response('Todo Successfully Updated.', @todo)
    else
      json_error_response('Something Went Wrong.', @todo.errors.full_messages)
    end
  end

  def destroy
    if @todo.destroy
      json_success_response('Todo Successfully Destroyed.', @todo)
    else
      json_error_response('Something Went Wrong', @todo.errors.full_messages)
    end
  end

  private
  def todo_params
    params.permit(:title, :day)
  end

  def get_todo
    @todo = Todo.find_by_id(params[:id])
  end
end
