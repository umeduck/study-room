class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :only_user, only: :destroy
  def new
    @room = Room.new
  end
  def create
    @room = Room.new(room_params)
    tag_list = params[:room][:name].split(',')
    if @room.save
      @room.save_tags(tag_list)
      redirect_to root_path
    else
      @room = Room.new
      render :new
    end
  end
  def destroy
    @room.destroy
    redirect_to user_path(current_user.id)
  end

  private

  def room_params
    params.require(:room).permit(:title).merge(user_id: current_user.id)
  end

  def only_user
    @room = Room.find(params[:id])
    redirect_to root_path unless current_user.id == @room.user_id
  end
  
  
end
