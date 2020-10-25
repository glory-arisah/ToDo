class TasksController < ApplicationController
  before_action :find_list
  before_action :find_task, only: [:update, :edit, :toggle_check, :destroy]

  def index
    @tasks = @lists.tasks
  end

  def new
    @task = @list.tasks.new

    respond_to do |format|
      format.js
    end
  end

  def create
    @list = current_user.lists.find_by(id: params[:list_id])
    @task = @list.tasks.new(task_params)

    if @task.save
      respond_to do |format|
        format.html { redirect_to list_path(@list) }
      end
    else
      flash[:errors] = @task.errors.full_messages
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @task.update(task_params)
      respond_to do |format|
        format.html { redirect_to list_path(@list) }
      end
    else
      flash[:errors] = @task.errors.full_messages
      render :edit
    end
  end

  def toggle_check
    @task.update(task_check: !@task.task_check) if @task
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to list_path(@list) }
    end
  end

  private

  def task_params
    params.require(:task).permit(:description)
  end

  def find_list
    @list = current_user.lists.find_by(id: params[:list_id])
  end

  def find_task
    @task = @list.tasks.find_by(id: params[:id])
  end
  
end
