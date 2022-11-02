class UsersController < ApplicationController
  before_action user_only, only: :edit
  def show
    @user = User.find(params[:id])
    @school_year = SchoolYear.find(@user.school_year_id)
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :school_year_id)
  end

  def user_only
    redirect_to root_path unless current_user.id == @room.user_id
  end
end
