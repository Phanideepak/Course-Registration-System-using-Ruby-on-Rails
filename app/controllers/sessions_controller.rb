class SessionsController < ApplicationController
  def new
  end

  def create
	@user = User.find_by_name(params[:session][:name])
	if @user && @user.authenticate(params[:session][:password])
		session[:user_id] = @user.id
		flash[:notice] = "You have successfully logged in."
		redirect_to '/'
	else
		flash[:notice] = "Wrong credentials"
	    redirect_to '/login'
	end 
  end

  def destroy 
	session[:user_id] = nil 
	flash[:notice] = "You have successfully logged out."
	redirect_to '/' 
  end

end
