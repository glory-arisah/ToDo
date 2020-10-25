class ListsController < ApplicationController
  before_action :find_list, only: [:show, :edit, :update, :destroy]

  def index
    @lists = current_user.lists.all.order("created_at DESC")
  end

  def show
    @tasks = @list.tasks.all
  end

  def new
    @list = current_user.lists.new

    respond_to do |format|
      format.js
    end
  end

  def create
    @list = current_user.lists.new(list_params)

    if @list.save
      respond_to do |format|
        format.html { redirect_to root_path }
      end
    else
      flash[:errors] = @list.errors.full_messages
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @list.update(list_params)
      redirect_to root_path
    else
      flash[:errors] = @list.errors.full_messages
      render :edit
    end
  end

  def destroy
    @list.destroy
    redirect_to root_path
  end

  private

  def list_params
    params.require(:list).permit(:title)
  end

  def find_list
    @list = current_user.lists.find_by(id: params[:id])
  end
end
