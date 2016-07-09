class BindersController < ApplicationController
  before_action :authenticate_user!
  before_action :owned_binder_crud, except: [:label, :filter]
  before_action :owned_binder_special, only: [:label, :filter]


  # GET /binders
  # GET /binders.json
  def index
    @binders = Binder.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @binders }
    end
  end

  # GET /binders/1
  # GET /binders/1.json
  def show
    @binder = Binder.find(params[:id])
    @owner = User.find(@binder.user_id).user_name
    @unbooked = @binder.receipts.all.select{|b| !b.booked }
    @booked = @binder.receipts.all.select{|b| b.booked }.select{|b| !b.approved}
    @bookedsum = receipts_sum(@booked)
    @approved = @binder.receipts.all.select{|b| b.approved }.select{|b| !b.paid}
    @approvedsum = receipts_sum(@approved)
    @paid = @binder.receipts.all.select{|b| b.paid }
    @paidsum = receipts_sum(@paid)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @binder }
    end
  end

  def filter
    @binder = Binder.find(params[:binder_id])
    @tag = params[:tag]
    if params[:tag]
      @receipts = @binder.receipts.tagged_with(@tag)
    else
      @receipts = @binder.receipts
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @binder }
    end
  end


  def label
    @binder = Binder.find(params[:binder_id])
    @receipts = @binder.receipts.all.select{|b| !b.booked }
    if @receipts.first
      @receipt = @receipts.first
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @binder }
    end
  end

  # GET /binders/new
  # GET /binders/new.json
  def new
    @binder = current_user.build_binder

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @binder }
    end
  end

  # GET /binders/1/edit
  def edit
    @binder = Binder.find(params[:id])
    @receipts = @binder.receipts
    @owner = User.find(@binder.user_id)
  end

  # POST /binders
  # POST /binders.json
  def create
    @binder = current_user.create_binder(binder_params)

    respond_to do |format|
      if @binder.save
        if params[:images]
          # The magic is here ;)
          params[:images].each { |image|
            @binder.receipts.create(image: image)
          }
        end

        format.html { redirect_to @binder, notice: 'binder was successfully created.' }
        format.json { render json: @binder, status: :created, location: @binder }
      else
        format.html { render action: "new" }
        format.json { render json: @binder.errors, status: :unprocessable_entity }
      end
    end
    @binder.save
  end

  # PUT /binders/1
  # PUT /binders/1.json
  def update
    @binder = Binder.find(params[:id])

    respond_to do |format|
      if @binder.update_attributes(binder_params)
        if params[:images]
          # The magic is here ;)
          params[:images].each { |image|
            @binder.receipts.create(image: image)
          }
        end
        format.html { redirect_to @binder, notice: 'Binder was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @binder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /binders/1
  # DELETE /binders/1.json
  def destroy
    @binder = Binder.find(params[:id])
    @binder.destroy

    respond_to do |format|
      format.html { redirect_to binders_url }
      format.json { head :no_content }
    end
  end

  private

  def receipts_sum(receipts)
    sum = 0
    receipts.each do |receipt|
        sum += receipt.amount
    end
    sum
  end

  def binder_params
    params.permit(:receipts)
  end

  def owned_binder_crud
    @binder = Binder.find(params[:id])
    @user = User.find(@binder.user)
    unless current_user == @user
      flash[:alert] = "Those receipts don't belong to you!"
      redirect_to root_path
    end
  end

  def owned_binder_special
    @binder = Binder.find(params[:binder_id])
    @user = User.find(@binder.user)
    unless current_user == @user
      flash[:alert] = "Those receipts don't belong to you!"
      redirect_to root_path
    end
  end

end
