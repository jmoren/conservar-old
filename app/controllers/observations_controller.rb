class ObservationsController < ApplicationController
  def index
    @observations = Observation.all
  end

  def show
    @observation = Observation.find(params[:id])
    @report = @observation.report
  end

  def new
    @report = Report.find_by_code(params[:report_id])
    @observation = @report.observations.new
  end

  def create
    @report = Report.find_by_code(params[:report_id])
    @observation = @report.observations.new(params[:observation])
    @observation.user = current_user
    if @observation.save
      redirect_to @observation, :notice => "Successfully created observation."
    else
      render :action => 'new'
    end
  end

  def edit
    @observation = Observation.find(params[:id])
  end

  def update
    @observation = Observation.find(params[:id])
    @observation.user = current_user if @observation.user.nil?
    if @observation.update_attributes(params[:observation])
      redirect_to @observation, :notice  => "Successfully updated observation."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @observation = Observation.find(params[:id])
    @observation.destroy
    redirect_to observations_url, :notice => "Successfully destroyed observation."
  end
end

