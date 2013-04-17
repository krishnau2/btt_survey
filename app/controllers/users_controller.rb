class UsersController < ApplicationController
	skip_before_filter :authenticate
	
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
  		UserMailer.verify_email(@user).deliver
  		redirect_to root_url, :notice => "Signed up! Check your email and follow the instructions to verify email address."
  	else
  		render "new"
  	end
  end
end
