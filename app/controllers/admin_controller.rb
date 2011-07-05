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

    #items [cat|subcat, cant.]
    @items_by_category = []
    Item.group(:item_category_id).size.each do |cat,value|
      @items_by_category << [ ItemCategory.find(cat).name, value ]
    end
    @items_by_subcategory = []
    Item.group(:item_subcategory_id).size.each do |cat,value|
      @items_by_subcategory << [ ItemCategory.find(cat).name, value ]
    end

    #deteriorations [nombre, cant.]
    @total_dets = Deterioration.count
    @dets = []
    Deterioration.group(:det_category_id).size.each do |detid,value|
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

