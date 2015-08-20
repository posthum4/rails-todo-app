class TodosController < ApplicationController

  def index
    @todos = Todo.all
    @todo = Todo.new
  end

  def show
  end

  def new
    @todo = Todo.new
  end

  def edit
    @todo = Todo.find_by_id(params[:id])
  end

  def create
    todo = Todo.new(description: params[:todo][:description])
    todo.save
    redirect_to root_path
  end

  def update
    todo = Todo.find_by_id(params[:id])
    if params[:completed]
      todo.update(completed: true)
    else
      todo.update(description: params[:todo][:description])
    end
    redirect_to root_path
  end

  def destroy
    todo = Todo.find_by_id(params[:id])
    todo.destroy
    redirect_to root_path
  end

  def completed
    @todos = Todo.where(completed: true)
    @todo = Todo.new
  end

  def active
    @todos = Todo.where(completed: false)
    @todo = Todo.new
  end
# update, destroy, create

end
