# app/controllers/todos_controller.rb
class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]

  # get /todos
  def index
    # get current user todos
    @todos = current_user.todos
    json_response @todos
  end

  def show
    @todo = current_user.todos.create!(todo_params)
    json_response @todo
  end

  # POST /todos
  def create
    # Create todos belonging to current user
    @todo = current_user.todos.create!(todo_params)
    json_response @todo, :created
  end

  def update
    @todo.update(todo_params)
    head :no_content
  end

  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  # remove 'created_by' from list of permitted parameters
  def  todo_params
    params.permit(:title)
  end
end
