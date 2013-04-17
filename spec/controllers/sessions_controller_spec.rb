require 'spec_helper'

describe SessionsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

	describe "When log in" do
		before :each do 
    	user_params = {:user_name => "kkk", :email => "kkk@gmail.com", :password => "kk", :password_confirmation => "kk"}
    	@user = User.create(user_params)
		end
    it "should show flash notice for un verified email" do
    	login_params = {:email => "kkk@gmail.com", :password => "kk"}
      post :create, login_params
      flash[:notice].should be_eql "Email not verified."
      response.should render_template :new
    end
    it "should show flash notice for invalid user details" do
    	@user.update_attribute(:verified, true)
    	login_params = {:email => "kkk@gmail.com", :password => "wrong"}
      post :create, login_params
      flash[:notice].should be_eql "Invalid email or password"
      response.should render_template :new
    end
    it "should set user session variable and redirect to root url" do
      @user.update_attribute(:verified, true)
    	login_params = {:email => "kkk@gmail.com", :password => "kk"}
      post :create, login_params
      flash[:notice].should be_eql "Logged in"
      session[:user_id].should be_eql @user.id
      response.should redirect_to root_url
    end
  end

  describe "GET verification" do
  	before :each do 
    	user_params = {:user_name => "k", :email => "k@gmail.com", :password => "kk", :password_confirmation => "kk"}
    	@user = User.create(user_params)
		end

		it "should verify email and redirect to log in url" do
	  	get :verification, :email_token => @user.email_verification_token
	  	flash[:notice].should be_eql "Email verified."
		  response.should redirect_to log_in_path
		end
		it "should redirect to sign up page for invalid token" do
	  	get :verification, :email_token => "a" * 10
	  	flash[:notice].should be_eql "Email not verified, Invalid details."
		  response.should redirect_to sign_up_path
		end
  end

  describe "Log out" do
  	it "should clear the user sessions" do
	  	delete :destroy
  	  session[:user_id].should be_nil
  	  session[:admin].should be_nil
  	end
  end

end
