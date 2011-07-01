class GalleriesController < ApplicationController
  protect_from_forgery :except => [:upload]

  def parent
    if params[:report_id]
      @parent = Report.find_by_code(params[:report_id])
    elsif params[:task_id]
      @parent = Task.find(params[:task_id])
    end
  end
  def index
    @galleries = Gallery.page params[:page]
  end

  def show
    @gallery = Gallery.find(params[:id])
  end

  def new
    @gallery = parent.galleries.new
  end

  def create

    @gallery = parent.galleries.new(params[:gallery])
    @gallery.user = current_user
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
      render :text => { :success => false }
    end
  end

  def update_in_place
    @gallery = Gallery.find(params[:element_id])
    @gallery.update_attributes(params[:field] => params[:update_value])
    render :text => @gallery.send(params[:field])
  end
  def get_gallery_1
    @gallery = Gallery.find(params[:gallery_1])
  end
  def get_gallery_2
    @gallery = Gallery.find(params[:gallery_2])
  end
end

