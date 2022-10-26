class RoomsController < ApplicationController
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
  private

  def room_params
    params.require(:room).permit(:title).merge(user_id: current_user.id)
  end
  
  
end
