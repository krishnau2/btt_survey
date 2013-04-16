require 'spec_helper'

describe User do
  it { should respond_to :user_name }
  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :password_hash }
  it { should respond_to :password_salt }
  it { should respond_to :email_verification_token }
  it { should respond_to :verified }
  it { should respond_to :admin }

  context "when validating" do
  	context "user_name" do
	    it "should validate presence of user_name" do
	      user = FactoryGirl.build(:user, :user_name => nil)
	      user.should have(1).errors_on(:user_name)
	    end

	    it "should validate uniqueness of user_name" do
	      user = FactoryGirl.create(:user)
	      dup_user = user.dup
	      dup_user.should have(1).errors_on(:user_name)
	    end
  	end
  	context "email" do
	    it "should validate presence of email" do
	      user = FactoryGirl.build(:user, :email => nil)
	      user.should_not be_valid
	    end
	    it "should validate uniqueness of email" do
	      user = FactoryGirl.create(:user)
	      dup_user = user.dup
	      dup_user.should have(1).errors_on(:email)
	    end
			it "should validate uniqueness with case sensitive of email" do
	    	user = FactoryGirl.create(:user, {:email => "first@first.com"})
	    	dup_user = FactoryGirl.build(:user, {:email => "FIRST@first.com"})
	    	dup_user.should have(1).errors_on(:email)
	    end
	    it "should validate format of email" do
	    	user = FactoryGirl.build(:user, {:email => "invalid_format"})
	    	user.should have(1).errors_on(:email)
	    end
  	end
  	context "password" do
  	  it "should validate presence of password" do
  	    user = FactoryGirl.build(:user, :password => nil)
  	    user.should_not be_valid
  	  end
  	  it "should validate confirmation_of password" do
  	    user = FactoryGirl.build(:user, :password_confirmation => "wrong")
  	    user.should have(1).errors_on(:password)
  	  end
  	end
  end
  context "when sign up" do
    it "should create password_salt" do
      user = FactoryGirl.create(:user)
      user.password_salt.should_not be_blank 
    end
    it "should create password_hash" do
      user = FactoryGirl.create(:user)
      user.password_hash.should_not be_blank 
    end
    it "should create email_verification_token" do
      user = FactoryGirl.create(:user)
      user.email_verification_token.should_not be_blank 
    end
  end
  context "when log in" do
    it "should validate user with given email and password(valid)" do
      user = FactoryGirl.create(:user, :email => "test@test.com")
      login_user = User.authenticate(user.email,"my_password")
      login_user.should be_eql user
    end
    it "should validate user with given email and password(invalid)" do
      user = FactoryGirl.create(:user, :email => "test@test.com")
      login_user = User.authenticate(user.email,"wrong_password")
      login_user.should be_nil
    end
  end
  context "when verifying email" do
    it "update verified to true for valid email_verification_token" do
      user = FactoryGirl.create(:user)
      token = user.email_verification_token
      user_to_verify = User.verify_email(token)
      user_to_verify.should be_eql user
      user_to_verify.verified?.should be_true
    end
		it "should not update verified to true for invalid email_verification_token" do
      user = FactoryGirl.create(:user)
      token = 'a' * 10
      user_to_verify = User.verify_email(token)
      user_to_verify.should be_nil
    end


  end
end
