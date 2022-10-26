class UsersController < ApplicationController
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
end
