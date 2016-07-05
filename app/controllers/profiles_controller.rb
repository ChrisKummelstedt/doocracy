class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :owned_profile, only: [:edit, :update]
  before_action :set_user

  def show
    @user ||= current_user
    @projects = @user.projects
    @skills = @user.skills.all
  end

  def edit
    @user = current_user
    @skills = current_user.skills.all
    @skill = current_user.skills.new
  end

  def update
    if @user.update(profile_params)
      flash[:success] = 'Your profile has been updated.'
      redirect_to profile_path(@user.user_name)
    end
  end

  private

  def set_user
    @user = User.find_by(user_name: params[:user_name])
  end

  def profile_params
    params.require(:user).permit(:avatar, :bio, :skype, :phone_number, :city, :country)
  end

  def owned_profile
    @user = User.find_by(user_name: params[:user_name])
    unless current_user == @user
      flash[:alert] = "That profile doesn't belong to you!"
      redirect_to root_path
    end
  end

end
