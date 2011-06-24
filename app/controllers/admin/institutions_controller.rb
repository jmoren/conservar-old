class Admin::InstitutionsController < AdminController
  def new
    @institution = Institution.new
  end
  def create
    @institution = Institution.new(params[:institution])
    @institution.save
    redirect_to admin_configuration_path
  end
  def update_in_place
    @institution = Institution.find(params[:element_id])
    @institution.update_attributes(params[:field] => params[:update_value])
    render :text => @institution.send(params[:field])
  end
  def edit
    @institution = Institution.find(params[:id])
  end
  def update
    @institution = Institution.find(params[:id])
    if @institution.update_attributes(params[:institution])
      redirect_to admin_configuration_path
    else
      render 'edit'
    end
  end
end

