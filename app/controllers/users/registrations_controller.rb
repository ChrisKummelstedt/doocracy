class Users::RegistrationsController < Devise::RegistrationsController

  def new
    super
  end

  def create
    super
  end

  def update
    super
  end

  private

  def sign_up_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :current_password)
  end


  protected

  def after_update_path_for(resource)
    case resource
    when :user, User
      "/#{current_user.user_name}"
    else
      super
    end
  end


end
