# encoding: utf-8
class ReportsController < ApplicationController
  respond_to :html, :json

  def index
    @reports = Report.page params[:page]
    if params[:status] && !params[:status].blank?
      @reports = Report.where(:status => params[:status]).page params[:page]
    end
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
      redirect_to @report, :notice => t("views.flash.create")
    else
      render :action => 'new'
    end
  end

  def edit
    @report = Report.find(params[:id])
    if (@report.closed? && !current_user.admin?)
      redirect_to @report, :notice => "El reporte ya esta cerrado, no puede editarlo"
    else
      @budget_work = @report.hours * CONFIG['price_per_hour'].to_f
    end
  end

  def update
    @report = Report.find(params[:id])
    if @report.update_attributes(params[:report])
      redirect_to @report, :notice  => t("views.flash.edit")
    else
      render :action => 'edit'
    end
  end

  def conclusion
    @report = Report.find(params[:id])
    @budget_work = @report.hours * CONFIG['price_per_hour'].to_f
  end

  def destroy
    @report = Report.find(params[:id])
    if !current_user.admin?
      redirect_to @report, :notice => "No puede eliminar el reporte si no es administrador"
    else
      @report.destroy
      redirect_to reports_url, :notice => t("views.flash.delete")
    end
  end

  def close
    @report = Report.find(params[:id])
    @report.close
    redirect_to conclusion_report_path(@report), :notice => t("views.flash.closed.report", :code => @report.code)
  end
  def open
    @report = Report.find(params[:id])
    if (@report.closed? && !current_user.admin?)
      redirect_to @report, :notice => "El reporte ya esta cerrado, no puede reabrirlo si no es administrador"
    else
      @report.open
      redirect_to @report, :notice => t("views.flash.open.report", :code => @report.code)
    end
  end

  def compare_galleries
    @report = Report.find(params[:id])
    @galleries = @report.galleries
  end
  def print
    @report = Report.find(params[:id])
    @institution = Institution.first
    render :layout => false
  end
#  def deteriorations_to_gantt
#    @report = Report.find(params[:id])
#    @deteriorations = @report.deteriorations.collect(&:to_ghash)
#    respond_with(@deteriorations)
#  end
end

