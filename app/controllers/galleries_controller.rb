class GalleriesController < ApplicationController

  def parent
    if params[:report_id]
      return @parent = Report.find(params[:report_id])
    elsif params[:task_id]
      return @parent = Task.find(params[:task_id])
    end
  end
  def index
    @galleries = Gallery.all
  end

  def show
    @gallery = Gallery.find(params[:id])
  end

  def new
    @gallery = parent.galleries.new
  end

  def create
    @gallery = parent.galleries.new(params[:gallery])
    if @gallery.save
      redirect_to uploader_gallery_path(@gallery), :notice => "Successfully created gallery."
    else
      render :action => 'new'
    end
  end

  def edit
    @gallery = Gallery.find(params[:id])
  end

  def update
    @gallery = Gallery.find(params[:id])
    if @gallery.update_attributes(params[:gallery])
      redirect_to uploader_gallery_path(@gallery), :notice  => "Successfully updated gallery."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @gallery = Gallery.find(params[:id])
    @gallery.destroy
    redirect_to galleries_url, :notice => "Successfully destroyed gallery."
  end

  def uploader
    @gallery = Gallery.find(params[:id],:include => :photos)
  end
  def upload
    @gallery = Gallery.find(params[:id])
    @photo  = @gallery.photos.new(:image => params[:file])
    if @photo.save
      render :json => { :success => true }
    else
      render :json => { :success => false, :error => 'There was an error. Please try again' }
    end
  end
  def update_in_place
    @gallery = Gallery.find(params[:element_id])
    @gallery.update_attributes(params[:field] => params[:update_value])
    render :text => @gallery.send(params[:field])

  end
end

