class SkillsController < ApplicationController
  def index
    @user = current_user
    @skills = @user.skills.all
  end

  def create
    @user = current_user
    @skill = Skill.create(skill_params)
    @user.skills << @skill
    respond_to do |format|
      format.html { redirect_to skills_path }
      format.js { }
    end
  end

  def destroy
    @skill = Skill.find(params[:id])
    @skill.destroy

    respond_to do |format|
      format.html { redirect_to skills_path }
      format.js { }
    end
  end

  private
  def skill_params
    params.require(:skill).permit(:skill, :skilllevel, :description)
  end
end
