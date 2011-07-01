class ItemsController < ApplicationController
  def index
    @items = Item.page params[:page]
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(params[:item])
    @item.user = current_user
    if @item.save
      redirect_to complete_fields_item_path(@item), :notice => "Successfully created item."
    else
      render :action => 'new'
    end
  end
  def complete_fields
    @item = Item.find(params[:id])
    subcategory = @item.subcategory
    subcategory.generic_fields.each do |field|
      case field.field_style
      when 'entero'
        @item.generic_integer_fields.build(:label_attribute => field.name)
      when 'float'
        @item.generic_float_fields.build(:label_attribute => field.name)
      when 'string'
        @item.generic_text_fields.build(:label_attribute => field.name)
      when 'texto'
        @item.generic_text_areas.build(:label_attribute => field.name)
      when 'boolean'
        @item.generic_boolean_fields.build(:label_attribute => field.name)
      end
    end
  end

  def edit
    @item = Item.find(params[:id])
    subcategory = @item.subcategory
    subcategory.generic_fields.each do |field|
      case field.field_style
      when 'entero'
        @item.generic_integer_fields.create(:label_attribute => field.name) unless @item.generic_integer_fields.find_by_label_attribute(field.name)
      when 'float'
        @item.generic_float_fields.create(:label_attribute => field.name) unless @item.generic_float_fields.find_by_label_attribute(field.name)
      when 'string'
        @item.generic_text_fields.create(:label_attribute => field.name) unless @item.generic_text_fields.find_by_label_attribute(field.name)
      when 'texto'
        @item.generic_text_areas.create(:label_attribute => field.name) unless @item.generic_text_areas.find_by_label_attribute(field.name)
      when 'boolean'
        @item.generic_boolean_fieldsds.create(:label_attribute => field.name) unless @item.generic_boolean_fields.find_by_label_attribute(field.name)
      end
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params[:item])
      redirect_to @item, :notice  => "Successfully updated item."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_url, :notice => "Successfully destroyed item."
  end

  def get_subcategories
    @subcategories = ItemCategory.where(:item_category_id => params[:id])
    respond_to do |format|
      format.js do
        render :json => @subcategories.collect{|a| {:name => a.name, :id => a.id } }
      end
    end
  end
  def remove_collection
    sleep(10)
    @item = Item.find(params[:id])
    @item.update_attributes(:collection_id => nil )
  end
end

