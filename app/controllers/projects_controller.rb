class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :cfo_for_project, only: [:receipts, :cycle, :paymentsfile, :markaspaid]

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
    @cfo = cfo_show
    @receipts = Receipt.where(:umbrella => @project.id)
    @receiptstotal = receiptstotal
    @usercount = user_count
    @completed_todo = completed_todo
    @not_completed_todo = not_completed_todo
    unless @completed_todo.size == 0 || @not_completed_todo.size == 0
      @progress = (((@completed_todo.size.to_f)/((@not_completed_todo.size.to_f)+(@completed_todo.size.to_f)))*100).round
    end
  end

  def edit
    @project = Project.find(params[:id])
    @controller_list = controller_list
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
      end
    end
    @project.save
    @adminteam = @project.teams.create(title: "Admin Team", description: "Overview and accounting")
    @adminteam.users << current_user
    @project.controller << current_user.user_name

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

  def mine
    @my_projects = my_project_list
    @commitments = Todo.where(user_id: current_user.id)
  end

  def about
  end

  def receipts
    @notapproved = not_approved_project_receipts
    @notpaid = not_paid_project_receipts
    @paid = paid_project_receipts
  end

  def cycle
    @notapproved = not_approved_project_receipts.first
  end

  def paymentsfile
    @project = Project.find(params[:project_id])
    @payments = Receipt.where(:approvedby => current_user.id, :umbrella => @project.id)
    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"Outgoing Payments for #{@project.title}.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def markaspaid
    @project = Project.find(params[:project_id])
    @payments = Receipt.where(:approvedby => current_user.id, :umbrella => @project.id)
    @payments.each do |receipt|
      receipt[:paid] = true
      receipt[:paidby] = current_user.user_name
      receipt[:paiddate] = DateTime.now
      receipt.save
    end
    redirect_to :back
  end

  private

  def my_project_list
    @teams = current_user.teams
    projects = []
    @teams.each do |team|
      projects << team.project
    end
    projects.uniq
  end

  def receiptstotal
    @receiptstotal = 0
    @project.teams.each do |team|
      team.receipts.each do |receipt|
        @receiptstotal += receipt.amount
      end
    end
    @receiptstotal
  end

  def not_approved_project_receipts
    @project = Project.find(params[:project_id])
    not_approved_project_receipts = []
    @project.teams.each do |t|
      t.receipts.each do |r|
        if (r.approved == false || r.approved == nil)
          not_approved_project_receipts << r
        end
      end
    end
    not_approved_project_receipts
  end

  def not_paid_project_receipts
    @project = Project.find(params[:project_id])
    not_paid_project_receipts = []
    @project.teams.each do |t|
      t.receipts.each do |r|
        if (r.paid == false || r.paid == nil)
          not_paid_project_receipts << r
        end
      end
    end
    not_paid_project_receipts
  end

  def my_not_paid_project_receipts
    @project = Project.find(params[:project_id])

    not_paid_project_receipts = []
    @project.teams.each do |t|
      t.receipts.each do |r|
        if (r.paid == false || r.paid == nil)
          if (r.approvedby == current_user.id)
            not_paid_project_receipts << r
          end
        end
      end
    end
    not_paid_project_receipts
  end

  def paid_project_receipts
    @project = Project.find(params[:project_id])

    paid_project_receipts = []
    @project.teams.each do |t|
      t.receipts.each do |r|
        if r.paid == true
          paid_project_receipts << r
        end
      end
    end
    paid_project_receipts
  end

  def cfo_show
    @project = Project.find(params[:id])
    @cfos = @project.controller
    @cfos.include? current_user.user_name
  end

  def cfo_for_project
    @project = Project.find(params[:project_id])
    @cfos = @project.controller
    unless @cfos.include? current_user.user_name
      flash[:alert] = "You don't have receipt priviledges for this project!"
      redirect_to project_path(@project)
    end
  end

  def controller_list
    controller_list = []
    @project.teams.each do |team|
      team.users.each do |member|
        controller_list << [member.user_name, member.user_name]
      end
    end
    controller_list.uniq
  end

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
    params.require(:project).permit(:title, :description, :total_budget, :revenue, :image, :address, :search, {:inventory_ids => []}, {:controller => []})
  end


end
