class InventoriesController < ApplicationController
  before_action :authenticate_user!

  # GET /inventories
  # GET /inventories.json
  def index
    @inventories = Inventory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventories }
    end
  end

  # GET /inventories/1
  # GET /inventories/1.json
  def show
    @inventory = Inventory.find(params[:id])
    @owner = User.find(@inventory.user_id).user_name
    if params[:tag]
      @items = @inventory.items.tagged_with(params[:tag])
      @itemhash = inventory_array(@items)
    else
      @items = @inventory.items
      @itemhash = inventory_array(@items)
    end


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory }
    end
  end

  def filter
    @inventory = Inventory.find(params[:inventory_id])
    if params[:tag]
      @items = @inventory.items.tagged_with(params[:tag])
    else
      @items = @inventory.items
    end


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory }
    end
  end

  # GET /inventories/new
  # GET /inventories/new.json
  def new
    @inventory = Inventory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory }
    end
  end

  # GET /inventories/1/edit
  def edit
    @inventory = Inventory.find(params[:id])
    @items = @inventory.items
    @owner = User.find(@inventory.user_id)
  end

  # POST /inventories
  # POST /inventories.json
  def create
    @inventory = current_user.inventories.build(inventory_params)

    respond_to do |format|
      if @inventory.save

        if params[:images]
          # The magic is here ;)
          params[:images].each { |image|
            @inventory.items.create(image: image)
          }
        end

        format.html { redirect_to @inventory, notice: 'Inventory was successfully created.' }
        format.json { render json: @inventory, status: :created, location: @inventory }
      else
        format.html { render action: "new" }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
    @inventory.save
  end

  # PUT /inventories/1
  # PUT /inventories/1.json
  def update
    @inventory = Inventory.find(params[:id])

    respond_to do |format|
      if @inventory.update_attributes(inventory_params)
        if params[:images]
          # The magic is here ;)
          params[:images].each { |image|
            @inventory.items.create(image: image)
          }
        end
        format.html { redirect_to @inventory, notice: 'Inventory was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventories/1
  # DELETE /inventories/1.json
  def destroy
    @inventory = Inventory.find(params[:id])
    @inventory.destroy

    respond_to do |format|
      format.html { redirect_to inventories_url }
      format.json { head :no_content }
    end
  end

  private

  def inventory_array(items)
    inventoryitems = []
    items.each do |item|
      item.tag_list.each do |tag|
        inventoryitems << tag
      end
    end
    Hash[inventoryitems.group_by{|i| i }.map{|k,v| [k.capitalize,v.size]}]
  end


  def inventory_params
    params.require(:inventory).permit(:description, :name, :items)
  end

end
