class InventoriesController < ApplicationController
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

  def filter
    p @inventory = Inventory.find(params[:inventory_id])

    if params[:tag]
      p @items = @inventory.items.tagged_with(params[:tag])
    else
      @items = @inventory.items
    end


    respond_to do |format|
      format.html # show.html.erb
      p format.json { render json: @inventory }
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
  end

  # POST /inventories
  # POST /inventories.json
  def create
    @inventory = Inventory.new(inventory_params)

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

  def inventory_params
    params.require(:inventory).permit(:description, :name, :items)
  end

end
