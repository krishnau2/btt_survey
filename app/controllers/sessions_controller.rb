class SessionsController < ApplicationController

	skip_before_filter :authenticate
  
  def new
  end

  def create
  	user = User.authenticate(params[:email], params[:password])
  	if user
  		if user.verified?
				session[:user_id] = user.id  
				session[:admin] = true if user.admin?
	  		redirect_to root_url, :notice => "Logged in" 
	  	else
	  		flash[:notice] = "Email not verified."  
	      render "new" 	
	  	end
		else
			flash.now[:notice] = "Invalid email or password"  
      render "new" 
		end 
  end

  def destroy
  	session[:user_id] = nil  
    session[:admin] = nil
	  redirect_to root_url, :notice => "Logged out." 
  end

  def verification
  	user = User.verify_email(params[:email_token])
  	if user
  		flash[:notice] = "Email verified."  
  		redirect_to log_in_path
  	else
  		flash.now[:notice] = "Email not verified, Invalid details."
  		redirect_to sign_up_path
  	end
  end
end
