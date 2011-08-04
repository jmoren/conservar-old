class AlertsController < ApplicationController

  def parent
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

  def index
    @parent = parent
  end

  def show
    @alert = Alert.find(params[:id])
  end

  def new
    @parent = parent
    @alert = @parent.alerts.new
  end

  def create
    sleep 2
    @parent = parent
    @alert = @parent.alerts.new(params[:alert])
    @alert.save
  end

  def edit
    @alert = Alert.find(params[:id])
    @parent = @alert.alertable
  end

  def update
    @alert = Alert.find(params[:id])
    @parent = @alert.alertable
    @alert.update_attributes(params[:alert])
  end

  def destroy
    @alert = Alert.find(params[:id])
    @parent = @alert.alertable
    @alert.destroy
    redirect_to polymorphic_path([@parent,:alerts]), :notice => t("views.flash.delete")
  end

  def update_in_place
    @alert = Alert.find(params[:element_id])
    puts params[:field]
    puts  params[:update_value]
    @alert.update_attributes(params[:field] => params[:update_value])
    render :text => @alert.send(params[:field])
  end
end

