class ApplicationController < ActionController::Base
	helper_method :current_user, :require_user , :admin?, :student?

	def current_user 
	  @current_user ||= User.find(session[:user_id]) if session[:user_id] 
	end

	def require_user 
	  redirect_to '/login' unless current_user 
	end

	def admin?
		if current_user
			current_user.type_of_users == "Admin"
		end
	end

	def student?
		if current_user
			current_user.type_of_users == "Student"
		end
	end
end
