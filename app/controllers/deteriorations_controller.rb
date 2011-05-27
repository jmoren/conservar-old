class DeteriorationsController < ApplicationController
  respond_to :json, :html
  def show
    @report = Report.find(params[:report_id])
    @deterioration = Deterioration.find(params[:id],:include => :tasks)
  end

   def open
    @deterioration = Deterioration.find(params[:id])
    @deterioration.update_attributes(:fixed => false)
    redirect_to @deterioration.report, :notice => "Successfully opened deterioration."
  end
  def close
    @deterioration = Deterioration.find(params[:id])
    @deterioration.update_attributes(:fixed => true)
    redirect_to @deterioration.report, :notice => "Successfully closed deterioration."
  end

  def get_deterioration
    @deterioration = Deterioration.find(params[:det_id]) if !params[:det_id].blank?
    @report = @deterioration.report
    respond_with(@deterioration)
  end

end

