class Admin::UsersController < AdminController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to admin_users_path, :notice => "Thank you for signing up! You are now logged in."
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to admin_users_path, :notice => "Your profile has been updated."
    else
      render :action => 'edit'
    end
  end
end

