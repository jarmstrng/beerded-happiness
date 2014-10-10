class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.find_by(name: params[:name]).try(:authenticate, params[:password])
    if user
      session[:id] = user.id
      redirect_to '/'
    else
      flash[:error] = "Login fail womp womp"
      redirect_to '/login'
    end
  end

  def destroy
    session.clear
    redirect_to '/login'
  end

end
