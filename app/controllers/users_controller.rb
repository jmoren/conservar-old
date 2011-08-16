class UsersController < ApplicationController
  before_filter :login_required

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Su cuenta fue actualizada"
    else
      render :action => 'edit'
    end
  end
  def profile
    @items = Item.important(current_user,:important).page(params[:page])
    @reports = Report.where(:assigned_to => current_user.id)
    activity = Version.where(:whodunnit => current_user.id).group(:item_type, :item_id).limit(10).order(:created_at).size
    @my_activity = []
    activity.each do |a,b|
      @my_activity << Version.find_all_by_item_id_and_item_type(a[1],a[0])
    end
  end
end

