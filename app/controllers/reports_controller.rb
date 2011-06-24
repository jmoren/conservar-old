class ReportsController < ApplicationController
  respond_to :html, :json
  def index
    @reports = Report.all
  end

  def show
    @report = Report.find_by_code(params[:id])
    respond_with(@report.deteriorations,:inlcude => :tasks)
  end

  def new
    @report = Report.new
  end

  def create
    sleep 5
    @report = Report.new(params[:report])
    @report.user = current_user
    unless params.include?('has_date')
      @report.start_date = @report.end_date = nil
    end
    if @report.save
      redirect_to @report, :notice => "Successfully created report."
    else
      render :action => 'new'
    end
  end

  def edit
    @report = Report.find_by_code(params[:id])
  end

  def update
    @report = Report.find_by_code(params[:id])
    dates = {}
    unless params.include?('has_date')
      dates = { :start_date => nil, :end_date => nil }
    end
    if @report.update_attributes(params[:report].merge(dates) )
      redirect_to @report, :notice  => "Successfully updated report."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @report = Report.find_by_code(params[:id])
    @report.destroy
    redirect_to reports_url, :notice => "Successfully destroyed report."
  end
  def close
    @report = Report.find_by_code(params[:id])
    @report.close
    redirect_to @report, :notice => "Successfully closed report."
  end
  def open
    @report = Report.find_by_code(params[:id])
    @report.open
    redirect_to @report, :notice => "Successfully opened report."
  end

  def compare_galleries
    @report = Report.find_by_code(params[:id])
    @galleries = @report.galleries
  end
  def print
    @report = Report.find_by_code(params[:id])
    @institution = Institution.first
  end
#  def deteriorations_to_gantt
#    @report = Report.find(params[:id])
#    @deteriorations = @report.deteriorations.collect(&:to_ghash)
#    respond_with(@deteriorations)
#  end
end

