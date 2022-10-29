class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    @tags = @room.tags
    @messages = @room.messages
  end
end
