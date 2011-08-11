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
    @activity = Version.where(:whodunnit => current_user.id)
  end
end

