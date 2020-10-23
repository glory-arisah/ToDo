class TasksController < ApplicationController
  def index
    @lists = current_user.lists.find_by(id: params[:list_id])
    @tasks = @lists.tasks.order('created at DESC')
  end
  
  def new
    @list = current_user.lists.find_by(id: params[:list_id])
    @task = @list.tasks.new
  end

  def create
    @list = List.find_by(id: params[:list_id])
    @task = @list.tasks.new(task_params)

    if @task.save
      redirect_to list_path(@list)
    else
      render :new
      errors.add(:base, 'Your input is invalid')
    end
  end

  def edit
    @list = current_user.lists.find_by(id: params[:list_id])
    @task = @list.tasks.find_by(id: params[:id])
  end

  def update
    
    @list = current_user.lists.find_by(id: params[:list_id])
    @task = @list.tasks.find_by(id: params[:id])

    if @task.update(task_params)
      respond_to do |format|
        format.html { redirect_to list_path(@list) }
        
      end
    else
      render :edit
      errors.add(:task, 'could not be updated')
    end
  end

  def toggle_check
    pp params
    @list = current_user.lists.find_by(id: params[:list_id])
    @task = @list.tasks.find_by(id: params[:id])
    
    pp 'code'
    pp @task.task_check
    
    respond_to do |format|
     if @task.update(task_check: !@task.task_check)  
      format.js { render js: @task.task_check}
     end
    end
    pp @task.task_check
  end
  

  def destroy
    @list = current_user.lists.find_by(id: params[:list_id])
    @task = @list.tasks.find_by(id: params[:id])

    @task.destroy
    
    respond_to do |format|
      format.html { redirect_to list_path(@list) }
    end
  end

  private
  
  def task_params
    params.require(:task).permit(:description)
  end
end
