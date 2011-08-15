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
      redirect_to admin_users_path, :notice => "Se creo con exito el usuario #{@user.full_name}"
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to admin_users_path, :notice => "El perfil de #{@user.full_name} fue actualizado"
    else
      render :action => 'edit'
    end
  end

  def enable
    @user = User.find(params[:id])
    @user.enable
  end

  def disable
    @user = User.find(params[:id])
    @user.disable unless @user.id == current_user.id
  end

end

