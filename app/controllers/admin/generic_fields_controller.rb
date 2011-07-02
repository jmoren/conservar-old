class Admin::GenericFieldsController < AdminController
  def new
    @generic_field = GenericField.new
  end

  def create
    @generic_field = GenericField.new(params[:generic_field])
    if @generic_field.save
      redirect_to admin_item_category_path(@generic_field.item_category)
    else
      redirect_to admin_item_category_path(@generic_field.item_category),:alert => "El nombre " + @generic_field.errors[:name].to_sentence
    end
  end

  def edit
    @generic_field = GenericField.find(params[:id])
  end

  def update
    @generic_field = GenericField.find(params[:id])
    @generic_field.update_attributes(params[:generic_field])
    redirect_to admin_item_category_path(@generic_field.item_category)
  end
  # name and field_style
  def destroy
    @generic_field = GenericField.find(params[:id])
    category = @generic_field.item_category
    if params[:delete_fields]
      @items = Item.where(:item_subcategory_id => category)
      puts @items.first
      case @generic_field.field_style
      when "entero"
        @items.each do |item|
          item.generic_integer_fields.find_by_label_attribute(@generic_field.name).destroy
        end
      when "string"
        @items.each do |item|
          item.generic_text_fields.find_by_label_attribute(@generic_field.name).destroy
        end
      when "text"
        @items.each do |item|
          item.generic_text_areas.find_by_label_attribute(@generic_field.name).destroy
        end
      when "float"
        @items.each do |item|
          item.generic_float_fields.find_by_label_attribute(@generic_field.name).destroy
        end
      when "boolean"
        @items.each do |item|
          item.generic_boolean_fields.find_by_label_attribute(@generic_field.name).destroy
        end
      end
    end
    @generic_field.destroy
  end
end

