class SpecialTasksController < ApplicationController
  def index
    @special_tasks = SpecialTask.scoped
    if params[:q]
      @special_tasks = @special_tasks.by_collection(params[:q][:collection]) if params[:q][:collection]
      @special_tasks = @special_tasks.by_user(params[:q][:user]) if params[:q][:user]
    end
    @special_tasks = @special_tasks.page params[:page]
    @collections = Collection.all
    @users = User.where(:enabled => true)
  end

  def show
    @special_task = SpecialTask.find(params[:id])
  end

  def new
    @special_task = SpecialTask.new
    @collection = Collection.find(params[:collection])
  end

  def create
    @special_task = SpecialTask.new(params[:special_task])
    @special_task.user = current_user
    if @special_task.save
      redirect_to @special_task.collection, :notice => "Successfully created special task."
    else
      render :action => 'new'
    end
  end

  def edit
    @special_task = SpecialTask.find(params[:id])
    @collection = @special_task.collection
  end

  def update
    @special_task = SpecialTask.find(params[:id])
    if @special_task.update_attributes(params[:special_task])
      redirect_to @special_task.collection, :notice  => "Successfully updated special task."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @special_task = SpecialTask.find(params[:id])
    @collection = @special_task.collection
    @special_task.destroy
    redirect_to @collection, :notice => "Successfully destroyed special task."
  end
end

