class ReportsController < ApplicationController
  respond_to :html, :json
  def index
    @reports = Report.page params[:page]
  end

  def show
    @report = Report.find(params[:id])
    respond_with(@report.deteriorations,:inlcude => :tasks)
  end

  def new
    @item = Item.find(params[:item_id])
    @report = @item.reports.new
    @deterioration = @report.deteriorations.build
  end

  def create
    @item = Item.find(params[:item_id])
    @report = @item.reports.new(params[:report])
    @report.generate_code
    @report.user = current_user
    if !params.include?('has_date')
      @report.start_date = @report.end_date = nil
    end
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

  def compare_galleries
    @report = Report.find(params[:id])
    @galleries = @report.galleries
  end
  def print
    @report = Report.find(params[:id])
    @institution = Institution.first
  end
#  def deteriorations_to_gantt
#    @report = Report.find(params[:id])
#    @deteriorations = @report.deteriorations.collect(&:to_ghash)
#    respond_with(@deteriorations)
#  end
end

