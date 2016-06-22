class ItemtagsController < ApplicationController
  before_action :set_itemtag, only: [:show, :edit, :update, :destroy]

  # GET /itemtags
  # GET /itemtags.json
  def index
    @itemtags = Itemtag.all
  end

  # GET /itemtags/1
  # GET /itemtags/1.json
  def show
  end

  # GET /itemtags/new
  def new
    @itemtag = Itemtag.new
  end

  # GET /itemtags/1/edit
  def edit
  end

  # POST /itemtags
  # POST /itemtags.json
  def create
    @itemtag = Itemtag.new(itemtag_params)

    respond_to do |format|
      if @itemtag.save
        format.html { redirect_to @itemtag, notice: 'Itemtag was successfully created.' }
        format.json { render :show, status: :created, location: @itemtag }
      else
        format.html { render :new }
        format.json { render json: @itemtag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /itemtags/1
  # PATCH/PUT /itemtags/1.json
  def update
    respond_to do |format|
      if @itemtag.update(itemtag_params)
        format.html { redirect_to @itemtag, notice: 'Itemtag was successfully updated.' }
        format.json { render :show, status: :ok, location: @itemtag }
      else
        format.html { render :edit }
        format.json { render json: @itemtag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /itemtags/1
  # DELETE /itemtags/1.json
  def destroy
    @itemtag.destroy
    respond_to do |format|
      format.html { redirect_to itemtags_url, notice: 'Itemtag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_itemtag
      @itemtag = Itemtag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def itemtag_params
      params.require(:itemtag).permit(:name)
    end
end
