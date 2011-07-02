class AdminController < ApplicationController
  before_filter :login_required_and_admin

  def index

  end
  def statistics
    #reportes
    @reporte_abiertos = Report.with_status('Abierto')
    @reporte_reabiertos = Report.with_status('Reabierto')
    @reportes_cerrados = Report.with_status('Cerrado')
    @total_reportes = Report.all.size

    #deteriorations
    @dets = []
    Deterioration.group(:det_category_id).size.each do |detid,value|
      @dets << { :det_category_id => DetCategory.find(detid).name,:size => value }
    end
  end

  def configuration
    @categories = DetCategory.all
    @institution = Institution.first
  end


end

