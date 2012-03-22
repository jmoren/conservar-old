class CollectionsController < ApplicationController
  def index
    @collections = Collection.all
  end

  def show
    @collection = Collection.find(params[:id], :include => :items)
    @items = @collection.items.page(params[:page])
  end

  def new
    @collection = Collection.new
  end

  def create
    @collection = Collection.new(params[:collection])
    @collection.user = current_user
    if @collection.save
      redirect_to @collection, :notice => t("views.flash.create")
    else
      render :action => 'new'
    end
  end

  def edit
    @collection = Collection.find(params[:id])
  end

  def update
    @collection = Collection.find(params[:id])
    if @collection.update_attributes(params[:collection])
      redirect_to @collection, :notice  => t("views.flash.edit")
    else
      render :action => 'edit'
    end
  end

  def destroy
    @collection = Collection.find(params[:id])
    @items = @collection.items
    if @collection.destroy
      unless @items.empty?
        @items.each do |item|
          item.remove_from_collection
        end
      end
    end
    redirect_to collections_url, :notice => t("views.flash.delete")
  end
  
  def list
    @collection = Collection.find(params[:id])
    
    if params[:option].present? && params[:option] == "unresolved"
      @items = @collection.get_items_unresolved
    else
      @items = @collection.get_all_items
    end
    render :layout => false
  end
end

