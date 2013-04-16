class SessionsController < ApplicationController
  
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
	  		flash.now[:notice] = "Email not verified."  
	      render "new" 	
	  	end
		else
			flash.now[:notice] = "Invalid email or password"  
      render "new" 
		end 
  end

  def verification
  	user = User.verify_email(params[:email_token])
  	if user
  		flash.now[:notice] = "Email verified."  
  		redirect_to log_in_path
  	else
  		flash.now[:notice] = "Email not verified, Invalid details."
  		redirect_to sign_up_path
  	end
  end
end
