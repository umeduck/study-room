class UsersController < ApplicationController
  before_action :user_find, only: [:edit, :update, :show]
  before_action :user_only, only: [:update, :edit]

  def show
    @school_year = SchoolYear.find(@user.school_year_id)
    @tags = Tag.all
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

  def user_find
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :school_year_id)
  end

  def user_only
    redirect_to root_path unless current_user.id == @user.id
  end
end
