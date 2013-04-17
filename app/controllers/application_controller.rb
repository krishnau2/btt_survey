class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate

  def authenticate
  	unless current_user
  		flash[:notice] = "Please log in"
      redirect_to root_url and return false
    end
  end

  def authorize_admin
  	unless admin?
  		flash[:notice] = "Access restricted"
      redirect_to root_url and return false
  	end
  end

  def current_user
  	User.find(session[:user_id]) if session[:user_id]
  end

  def admin?
  	current_user && current_user.admin?
  end
end
