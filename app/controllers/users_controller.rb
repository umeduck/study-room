class UsersController < ApplicationController
  def edit
  end
  def update
    if current_user.update(user_params)
      redirect root_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :school_year_id)
  end
end