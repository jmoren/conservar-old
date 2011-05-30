class ReportsController < ApplicationController
  respond_to :html, :json
  def index
    @reports = Report.all
  end

  def show
    @report = Report.find(params[:id])
    respond_with(@report.deteriorations,:inlcude => :tasks)
  end

  def new
    @report = Report.new
  end

  def create
    sleep 5
    @report = Report.new(params[:report])
    if @report.save
      redirect_to @report, :notice => "Successfully created report."
    else
      render :action => 'new'
    end
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    if @report.update_attributes(params[:report])
      redirect_to @report, :notice  => "Successfully updated report."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    redirect_to reports_url, :notice => "Successfully destroyed report."
  end
  def close
    @report = Report.find(params[:id])
    @report.close
    redirect_to @report, :notice => "Successfully closed report."
  end
  def open
    @report = Report.find(params[:id])
    @report.open
    redirect_to @report, :notice => "Successfully opened report."
  end
  def report_to_json
    @report = Report.find(params[:id])
  end
end

