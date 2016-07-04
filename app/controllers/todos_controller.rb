class TodosController < ApplicationController
  before_action :set_project, :set_team, :set_todos

  def create
    @todo = @team.todos.create(todo_params)
    @team.save
    respond_to do |format|
      format.html { redirect_to project_team_path(@project, @team) }
      format.js { }
    end
  end

  def destroy
    @todo = @team.todos.find(params[:id])
    @todo.destroy
    @team.save
    respond_to do |format|
      format.html { redirect_to project_team_path(@project, @team) }
      format.js { }
    end
  end

  def update
    @todo = Todo.find(params[:id])

    if @todo.completed
      @todo.completed = false
    else
      @todo.completed = true
    end
    @todo.save
    respond_to do |format|
      format.html { redirect_to project_team_path(@project, @team) }
      format.js { }
    end
  end

  def claim
    @todo = Todo.find(params[:id])
    @todo.user_id = current_user.id
    @todo.save
    flash[:notice] = "Awesome! Consider it's yours!"
    redirect_to(:back)
  end

  def unclaim
    @todo = Todo.find(params[:id])
    @todo.user_id = nil
    @todo.save
    flash[:notice] = "Phew! The item is no longer yours to do"
    redirect_to(:back)
  end



  private

  def set_todos
    @team = Team.find(params[:team_id])
    @todos = @team.todos.where(:completed => false)
    @completedtodos = @team.todos.where(:completed => 't')
  end

  def set_team
    @team = Team.find(params[:team_id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def todo_params
    params.require(:todo).permit(:description, :priority, :completed, :user_id)
  end
end
