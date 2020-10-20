class ListsController < ApplicationController
  
  def index
    @lists = List.all.order('created_at DESC')
  end

  def new
    @list = current_user.lists.new
  end

  def create
    @list = current_user.lists.new(list_params)

    if @list.save
      redirect_to root_path
    else
      render json: { notice: 'Your input is invalid' }
      render :new
    end
  end
  
  def edit
    @list = current_user.lists.find_by(id: params[:id])
  end

  def update
    @list = current_user.lists.find_by(id: params[:id])

    if @list.update(list_params)
      redirect_to root_path
    else
      render :edit
      errors.add(:list, 'cannot be updated')
    end
  end

  def show
    @list = current_user.lists.build
  end

  def destroy
    @list = current_user.lists.find_by(id: params[:id])
    @list.destroy
    render :index
  end

  private

  def list_params
    params.require(:list).permit(:title)
  end
end
