class DeteriorationsController < ApplicationController
  before_filter :set_report, :only => [:show]

  respond_to :json, :html
  def set_report
    @report = Report.find(params[:report_id])
  end
  def show
    @deterioration = Deterioration.find(params[:id],:include => :tasks)
  end

   def open
    @deterioration = Deterioration.find(params[:id])
    @deterioration.update_attributes(:fixed => false)
    if @deterioration.report.closed?
      @deterioration.report.open
    end
    redirect_to @deterioration.report, :notice => "Successfully opened deterioration."
  end
  def close
    @deterioration = Deterioration.find(params[:id])
    if @deterioration.update_attributes(:fixed => true)
      @deterioration.tasks.update_all(:hours => 0.0)
      redirect_to @deterioration.report, :notice => "Successfully closed deterioration."
    end
  end

  def get_deterioration
    unless params[:det_id].blank?
      @deterioration = Deterioration.find(params[:det_id])
      @report = @deterioration.report
      @deterioration = @deterioration.to_custom_hash
    end
    respond_with(@deterioration)
  end
  def update_in_place
    @deterioration = Deterioration.find(params[:element_id])
    if params[:field] == "det_category_id"
      params[:update_value] = DetCategory.find_by_name(params[:update_value]).id
      @deterioration.update_attributes(params[:field] => params[:update_value])
      render :text => @deterioration.det_category.name
    else
      @deterioration.update_attributes(params[:field] => params[:update_value])
      render :text => @deterioration.send(params[:field])
    end

  end
end

