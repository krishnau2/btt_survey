require 'spec_helper'

describe UsersController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end
	describe "When sign up" do
		describe "valid user info" do
			before :each do 
	    	@user_params = {:user_name => "kk", :email => "kk@gmail.com", :password => "kk", :password_confirmation => "kk"}
			end

	    it "redirects to root url for valid user info" do
	      post :create, user: @user_params
	      response.should redirect_to root_url
	    end

	    it "creates a new user" do
	      expect {
	        post :create, {:user => @user_params}
	      }.to change(User, :count).by(1)
	    end
    end

    it "should render the form back for invalid user info" do
      user_params = {:user_name => "kk", :email => "kk@gmail.com", :password => "", :password_confirmation => ""}
      post :create, user: user_params
      response.should render_template :new
    end
  end

end
