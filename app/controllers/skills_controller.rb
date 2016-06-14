class SkillsController < ApplicationController
  def index
    @skills = Skill.all
  end

  def create
    @skill = Skill.create(skill_params)
    respond_to do |format|
      format.html { redirect_to skills_path }
      format.js { }
    end
  end

  def destroy
    skill = Skill.find(params[:id])
    skill.destroy
    redirect_to skills_path
  end

  private
    def skill_params
      params.require(:skill).permit(:skill, :skilllevel, :description)
    end
end
