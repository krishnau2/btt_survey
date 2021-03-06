module ApplicationHelper
	def current_user
		User.find(session[:user_id]) if session[:user_id]
	end

	def admin?
		current_user && current_user.admin?
	end
end
