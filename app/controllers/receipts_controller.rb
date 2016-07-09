class ReceiptsController < ApplicationController
  # GET /receipts
  # GET /receipts.json
  def index
    @binder = Binder.find(params[:binder_id])
    @receipts = @binder.receipts

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @receipts }
    end
  end

  # GET /receipts/1
  # GET /receipts/1.json
  def show
    @binder = Binder.find(params[:binder_id])
    @receipt = @binder.receipts.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @receipt }
    end
  end

  # GET /receipts/new
  # GET /receipts/new.json
  def new
    @binder = Binder.find(params[:binder_id])
    @receipt = @binder.receipts.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @receipt }
    end
  end

  # GET /receipts/1/edit
  def edit
    @binder = Binder.find(params[:binder_id])
    @receipt = @binder.receipts.find(params[:id])
    # @receipt = receipt.find(params[:id])
  end

  # POST /receipts
  # POST /receipts.json
  def create
    @receipt = Receipt.new(params[:receipt])

    if @receipt.save
      respond_to do |format|
        format.html {
          render :json => [@receipt.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json {
          render :json => [@receipt.to_jq_upload].to_json
        }
      end
    else
      render :json => [{:error => "custom_failure"}], :status => 304
    end
  end

  # PUT /receipts/1
  # PUT /receipts/1.json
  def update
    @binder = Binder.find(params[:binder_id])
    @receipt = @binder.receipts.find(params[:id])
    @receipt.update(receipt_params)
    if booked && approved
      @receipt[:approveddate] = DateTime.now
      @receipt[:approvedby] = current_user.id
      @receipt.save
      respond_to do |format|
        if @receipt.update_attributes(receipt_params)
          format.html { redirect_to :back, notice: 'Receipt was successfully approved.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @receipt.errors, status: :unprocessable_entity }
        end
      end
    elsif booked
      @receipt[:bookeddate] = DateTime.now
      @receipt[:umbrella] = Project.find_by_id(Team.find(@receipt[:team_id]).project_id).id
      @receipt.save
      respond_to do |format|
        if @receipt.update_attributes(receipt_params)
          format.html { redirect_to :back, notice: 'Receipt was successfully booked.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @receipt.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to :back, notice: 'You need a purpose, a date, a team and an amount to book a receipt'
    end
  end

  # DELETE /receipts/1
  # DELETE /receipts/1.json
  def destroy
    #@binder = binder.find(params[:binder_id])
    #@receipt = @binder.receipts.find(params[:id])
    @receipt = Receipt.find(params[:id])
    @receipt.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def make_default
    @receipt = Receipt.find(params[:id])
    @binder = Binder.find(params[:binder_id])
    @binder.cover = @receipt.id
    @binder.save

    respond_to do |format|
      format.js
    end
  end


  private
  def booked
    (@receipt.name != "") && (@receipt.date != nil) && (@receipt.amount != "") && (@receipt.team_id != nil)  && (@receipt.booked)
  end

  def approved
    @receipt.approved
  end

  def receipt_params
    params.require(:receipt).permit(:name, :date, :amount, :booked, :bookeddate, :approved, :approveddate, :paid, :paiddate, :image, :tag_list, :tag, { tag_ids: [] }, :tag_ids, :team_id)
  end
end
