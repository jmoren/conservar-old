class TasksController < ApplicationController
  before_filter :set_report, :set_deterioration, :only => [:new,:create]

  def set_deterioration
    if params[:deterioration_id]
      @deterioration = Deterioration.find(params[:deterioration_id])
    end
  end
  def set_report
    if params[:report_id]
      @report = Report.find(params[:report_id])
    end
  end
  def index
    @tasks = Task.page params[:page]
  end

  def show
    @task = Task.find(params[:id])
  end
  def new
    if params[:det_id]
      @deterioration = Deterioration.find(params[:det_id])
      @task = @report.tasks.new(:deterioration_id => @deterioration.id)
    else
      @task = @report.tasks.new
    end
  end
  def create
    @task = @report.tasks.new(params[:task])
    @task.user = current_user
    if params[:task][:hours].to_f > 0
      @task.report.update_hours(params[:task][:hours].to_f)
    end
    if @task.save
      @task.deterioration.update_hours(params[:task][:hours].to_f)
      @task.deterioration.update_status
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
    if @task.update_attributes(params[:task])
      @task.deterioration.update_status
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

