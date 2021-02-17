class UsersController < ApplicationController

	def home

	end
	
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
	    if @user.save
	      session[:user_id] = @user.id
	      flash[:notice] = "User successfully created"
	      redirect_to '/'
	    else
	      flash[:notice] = "Username already exists"
	      redirect_to '/signup'
	    end
	end

	private

	def user_params
		params.require(:user).permit(:name, :type_of_users, :password)
	end
end
