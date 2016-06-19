class ItemsController < ApplicationController
  # GET /items
  # GET /items.json
  def index

    @inventory = Inventory.find(params[:inventory_id])

    @items = @inventory.items

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @inventory = Inventory.find(params[:inventory_id])
    @item = @inventory.items.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    #@inventory = Inventory.find(params[:inventory_id])

    @item = Item.find(params[:id])
    # @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item])

    if @item.save
      respond_to do |format|
        format.html {
          render :json => [@item.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json {
          render :json => [@item.to_jq_upload].to_json
        }
      end
    else
      render :json => [{:error => "custom_failure"}], :status => 304
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update

    @inventory = Inventory.find(params[:inventory_id])

    @item = @inventory.items.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(item_params)
        format.html { redirect_to inventory_path(@inventory), notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    #@inventory = Inventory.find(params[:inventory_id])
    #@item = @inventory.items.find(params[:id])
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def make_default
    @item = Item.find(params[:id])
    @inventory = Inventory.find(params[:inventory_id])

    @inventory.cover = @item.id
    @inventory.save

    respond_to do |format|
      format.js
    end
  end

  private

  def item_params
    params.require(:item).permit(:description, :inventory_id, :image)
  end
