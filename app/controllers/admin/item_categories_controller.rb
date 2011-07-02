class Admin::ItemCategoriesController < AdminController
  def show
    @subcategory = ItemCategory.find(params[:id])
  end
  def create
    @item_category = ItemCategory.new(params[:item_category])
    @item_category.save
    redirect_to admin_configuration_path
  end

  def enable_category
    @item_category = ItemCategory.find(params[:id])
    @item_category.enable
    redirect_to admin_configuration_path
  end

  def disable_category
    @item_category = ItemCategory.find(params[:id])
    @item_category.disable
    redirect_to admin_configuration_path
  end
end

