class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]


  def index
    @projects = Project.all
    if params[:search]
      @projects = Project.search(params[:search]).order("created_at DESC")
    else
      @projects = Project.all.order('created_at DESC')
    end
  end

  def show
    @project = Project.find(params[:id])
    @usercount = user_count
    @completed_todo = completed_todo
    @not_completed_todo = not_completed_todo
    unless @completed_todo.size == 0 || @not_completed_todo.size == 0
      @progress = (((@completed_todo.size.to_f)/((@not_completed_todo.size.to_f)+(@completed_todo.size.to_f)))*100).round
    end
  end

  def mine
    @my_projects = current_user.projects
    @commitments = Todo.where(user_id: current_user.id)
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if params[:inventory_ids]
      :inventory_ids.each do |inventory|
        i = Inventory.find_by_id(params[inventory])
        @project.inventories << i
        @project.save
      end
      @project.update(project_params)
      redirect_to project_path(@project)
    else
      @project.update(project_params)
      redirect_to project_path(@project)
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = "Project deleted successfully."
    redirect_to root_path
  end

  def new
    @project = current_user.projects.build
  end

  def create
    @project = current_user.projects.build(project_params)
    if params[:inventory_ids]
      :inventory_ids.each do |inventory|
        i = Inventory.find_by_id(params[inventory])
        @project.inventories << i
        @project.save
      end
    end
    if @project.save
      flash[:notice] = "Your project has been created."
      redirect_to project_path(@project)
    else
      flash[:notice] = "Your project has not been created, you left something blank."
      render :action=>'new'
    end
  end

  def user_projects_path
    @projects = current_user.projects(project_params)
  end

  def about
  end

  private

  def completed_todo
    completed = []
    @project.teams.each do |team|
      team.todos.each do |todo|
        completed << todo if todo.completed
      end
    end
    completed
  end

  def not_completed_todo
    not_completed = []
    @project.teams.each do |team|
      team.todos.each do |todo|
        not_completed << todo unless todo.completed
      end
    end
    not_completed
  end

  def user_count
    usercount = []
    @project.teams.each do |team|
      team.users.each do |team_member|
        usercount << team_member.user_name
      end
    end
    usercount.uniq.size
  end

  def project_params
    params.require(:project).permit(:title, :description, :total_budget, :image, :address, :search, {:inventory_ids => []})
  end


end
