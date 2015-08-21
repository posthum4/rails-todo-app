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
    p params
    if request.xhr?
      todo = Todo.new(description: params[:description])
      todo.save
      render json: todo
    else
      todo = Todo.new(description: params[:todo][:description])
      todo.save
      redirect_to root_path
    end
  end

  def update
    todo = Todo.find_by_id(params[:id])
    if params[:completed]
      todo.update(completed: true)
    else
      todo.update(description: params[:todo][:description])
    end
    todo = Todo.find_by_id(params[:id])
    if request.xhr?
      render json: {id: todo.id, completed: todo.completed}
    else
      redirect_to root_path
    end
  end

  def destroy
    todo = Todo.find_by_id(params[:id])
    todo.destroy
    if request.xhr?
      render json: {id: todo.id}
    else
      redirect_to root_path
    end
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
