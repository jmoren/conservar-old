class AdminController < ApplicationController
  before_filter :login_required_and_admin

  def index

  end
  def statistics
    @type = params['estadisticas'].present? ? params['estadisticas']['type'] : nil
    sm    = params['estadisticas'].present? ? params['estadisticas']['desde'] : '1'
    em    = params['estadisticas'].present? ? params['estadisticas']['hasta'] : '12'
    year  = params['estadisticas'].present? ? params['estadisticas']['anio'] : Date.today.year

    #reportes
    @reporte_abiertos = Report.with_status('Abierto')
    @reporte_reabiertos = Report.with_status('Reabierto')
    @reportes_cerrados = Report.with_status('Cerrado')
    @total_reportes = Report.all.size

    #items [cat|subcat, cant.]
    @total_items = Item.count
    @items_by_category = []
    Item.search_by(sm,em,year).group(:item_category_id).size.each do |cat,value|
      @items_by_category << [ ItemCategory.find(cat).name, value ]
    end
    @items_by_subcategory = []
    Item.search_by(sm,em,year).group(:item_subcategory_id).size.each do |cat,value|
      @items_by_subcategory << [ ItemCategory.find(cat).name, value ]
    end

    #deteriorations [nombre, cant.]
    @total_dets = Deterioration.count
    @dets = []
    Deterioration.search_by(sm,em,year).group(:det_category_id).size.each do |detid,value|
      det = DetCategory.find(detid).name
      @dets << [ det, value ]
    end

    #colecciones [nombre, cant. items]
    @collections = Collection.all

    #tasks
    @tasks = [Task.closed.size,Task.open.size]
  end

  def configuration
    @categories = DetCategory.all
    @institution = Institution.first
  end


end

