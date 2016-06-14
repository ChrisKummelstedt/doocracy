class SkilllistsController < ApplicationController
  def index
    @skilllists = Skilllist.all
  end

  def create
    Skilllist.create(skilllist_params)
    redirect_to root_path
  end

  def destroy
    skilllist = Skilllist.find(params[:id])
    skilllist.destroy
    redirect_to root_path
  end

  private
    def skilllist_params
      params.require(:skilllist).permit(:skill, :skilllevel, :description)
    end
end
