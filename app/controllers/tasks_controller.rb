class TasksController < ApplicationController
  before_filter :set_report, :except => [:show]

  def set_report
    @report = Report.find(params[:report_id])
  end
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    if params[:det_id]
      @deterioration = Deterioration.find(params[:det_id])
      @task = @report.tasks.new(:deterioration_id => params[:det_id])
    else
      @task = @report.tasks.new
    end
  end

  def create
    @task = @report.tasks.new(params[:task])
    if params[:closed]
      @task.closed_at = Time.now
    end
    if @task.save
      redirect_to report_deterioration_path(@task.report,@task.deterioration), :notice => "Successfully created task."
    else
      render :action => 'new'
    end
  end

  def edit
    @task = Task.find(params[:id])
    @deterioration = @task.deterioration
  end

  def update
    @task = Task.find(params[:id])
    if params[:closed]
      @task.closed_at = Time.now
    end
    if @task.update_attributes(params[:task])
      redirect_to report_deterioration_path(@task.report,@task.deterioration), :notice  => "Successfully updated task."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    report = @task.report
    deterioration = @task.deterioration
    @task.destroy
    redirect_to report_deterioration_path(@task.report,@task.deterioration), :notice => "Successfully destroyed task."
  end
end

