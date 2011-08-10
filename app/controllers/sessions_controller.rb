class SessionsController < ApplicationController
  skip_before_filter :login_required, :except => [:destroy]
  layout 'login'
  def new
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to profile_path, :notice => "Bienvenido #{user.full_name}"
      #redirect_to_target_or_default root_url, :notice => "Bienvenido #{user.full_name}"
    else
      flash.now[:alert] = "Nombre o email invalido"
      render :action => 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, :notice => "Ha salido del sistema"
  end
end

