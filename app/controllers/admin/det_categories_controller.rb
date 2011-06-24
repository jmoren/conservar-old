class Admin::DetCategoriesController < AdminController
  def create
    @category = DetCategory.new(params[:det_category])
    @category.save
  end

  def enable_category
    @category = DetCategory.find(params[:id])
    @category.enable
    redirect_to admin_configuration_path
  end

  def disable_category
    @category = DetCategory.find(params[:id])
    @category.disable
    redirect_to admin_configuration_path
  end

  def update_in_place
    @category = DetCategory.find(params[:element_id])
    @category.update_attributes(params[:field] => params[:update_value])
    render :text => @category.send(params[:field])
  end
end

