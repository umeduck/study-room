class MessagesController < ApplicationController
  before_action :instance_variable, only: [:index, :create]
  def index
    @tags = Tag.all
  end

  def create
    message = @room.messages.new(message_params)
    if message.save
      redirect_to room_messages_path(@room)
    else
      
      render :index
    end
  end

  private

  def instance_variable
    @message = Message.new
    @room = Room.find(params[:room_id])
    @room_tags = @room.tags
    @messages = @room.messages.includes(:user)
  end
  
  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end
end
