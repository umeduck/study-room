class TopsController < ApplicationController
  def index
    @rooms = Room.includes(:user)
    @tags = Tag.all
  end
end
