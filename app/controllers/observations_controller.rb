class ObservationsController < ApplicationController
  def new
    @report = Report.find_by_code(params[:report_id])
    @observation = @report.observations.new
  end

  def create
    @report = Report.find_by_code(params[:report_id])
    @observation = @report.observations.new(params[:observation])
    @observation.user = current_user
    @observation.save
  end

  def update_in_place
    @observation = Observation.find(params[:element_id])
    @observation.update_attributes(params[:field] => params[:update_value])
    render :text => @observation.send(params[:field])
  end

  def destroy
    @observation = Observation.find(params[:id])
    @observation_id = @observation.id
    @observation.destroy
  end
end

