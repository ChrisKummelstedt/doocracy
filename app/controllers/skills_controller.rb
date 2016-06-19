class SkillsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = current_user
    @skill = @user.skills.create(skill_params)
    respond_to do |format|
      format.html { redirect_to edit_profile_path(@user.user_name) }
      format.js { }
    end
  end

  def destroy
    @user = current_user
    @skill = @user.skills.find(params[:id])
    @skill.destroy

    respond_to do |format|
      format.html { redirect_to edit_profile_path(@user.user_name) }
      format.js { }
    end
  end

  private
  def skill_params
    params.require(:skill).permit(:skill, :skilllevel, :description)
  end
end
