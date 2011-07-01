class Admin::GenericFieldsController < AdminController
  def new
    @generic_field = GenericField.new
  end

  def create
    @generic_field = GenericField.new(params[:generic_field])
    @generic_field.save
    redirect_to admin_item_category_path(@generic_field.item_category)
  end

  def edit
    @generic_field = GenericField.find(params[:id])
  end

  def update
    @generic_field = GenericField.find(params[:id])
    @generic_field.update_attributes(params[:generic_field])
    redirect_to admin_item_category_path(@generic_field.item_category)
  end

  def destroy
    @generic_field = GenericField.find(params[:id])
    category = @generic_field.item_category
    @generic_field.destroy
    redirect_to admin_item_category_path(category)
  end
end

