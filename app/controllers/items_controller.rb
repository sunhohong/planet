# encoding: utf-8
class ItemsController < ApplicationController
	before_filter :authorize
	skip_before_filter :authorize, :only => [:index, :show, :search]

  # GET /items
  # GET /items.json
  def index
    @items = Item.order('created_at desc').page(params[:page]).per(10)

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
    @item = Item.new
  
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.valid?
        @item.next_step
        @item.save
        format.html { redirect_to edit_item_path(@item), notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])
    
    @item.attributes = params[:item]

    if params[:back_button]
      @item.previous_step
      @item.save
    elsif @item.valid?
      if @item.last_step?
        if @item.all_valid?
          @item.confirmed = true
          @item.save
          return respond_to do |format|    # last step && all vaild
            format.html { redirect_to @item, notice: 'Item was successfully updated.' }
            format.json { head :ok }
          end
        end
      else
        @item.next_step
      end
      @item.save
    end

    respond_to do |format|
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :ok }
    end
  end

  # GET /items/search
  # GET /items/search.xml
  def search
    # order
    if params[:order].blank?
      order_param = [:created_at, :desc]
    elsif params[:order] == 'location' && params[:current_location_id].present?
      cookies[:current_location_id] = { :value => params[:current_location_id], :expires => 15.days.from_now }
      cookies[:current_location_address] = { :value => Location.find(params[:current_location_id]).address, :expires => 15.days.from_now }
    else
      order_param = params[:order].split('_').collect { |s| s.to_sym }
      order_param[0] = :created_at if order_param[0] == :date
    end

    #search
    search = Item.search do
      keywords params[:query]

      all_of do
        with(:category_hierarchy, params[:category]) if params[:category].present?

        with(:created_at).greater_than(params[:period].to_i.days.ago) if params[:period].present?

        any_of do
          if params[:shipping_method] && params[:shipping_method].kind_of?(Array)
            params[:shipping_method].each do |p|
              with(:shipping_method, p)
            end
          end
        end
        any_of do
          if params[:location_si] && params[:location_si].kind_of?(Array)
            params[:location_si].each do |p|
              with(:location_si, p)
            end
          end
        end
      end

      if params[:order] == 'location' && params[:current_location_id].present?
        location_obj = Location.find(params[:current_location_id])
        order_by_geodist(:location, location_obj.latitude, location_obj.longitude)
      else
        order_by order_param[0], order_param[1]
      end
      facet :category_hierarchy

      paginate :page => params[:page], :per_page => 10
    end

    #result
    @items = search
    @facet = search.facet(:category_hierarchy).rows
    @category = Category.find(params[:category]) unless params[:category].blank?
    @info_categories = Category.find_all_by_facet(search.facet(:category_hierarchy).rows, params[:category])

    # below this line will be moved to widget
    @shipping_method_options = FieldValue.values_by_meta_id(1)
    @location_options = FieldValue.values_by_meta_id(2)
    @period_options = FieldValue.values_by_meta_id(3)

    respond_to do |format|
      format.html { render :action => "index" }
      format.xml { render :xml => @items }
    end
  end
end
