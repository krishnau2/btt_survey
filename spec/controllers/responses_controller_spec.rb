require 'spec_helper'

describe ResponsesController do

  before :each do 
    @survey = Survey.create!({"name" => "MyString"})
    user_params = {:user_name => "test", :email => "test@gmail.com", :password => "kk", :password_confirmation => "kk"}
    @user = User.create!(user_params)
    @user.update_attribute(:verified, true)
    session[:user_id] = @user.id
  end

  describe "GET new" do
    it "response should be success" do
      get :new, :survey_id => @survey.id
      response.should be_success
    end

    it "assigns a new response as @response" do
      get :new, :survey_id => @survey.id
      assigns(:response).should be_a_new(Response)
    end

    it "should redirect to show page if already answered." do
      @params = { :survey_id => @survey.id, :user_id => @user.id, :answers_attributes => [] }
      response = Response.create! @params
      get :new, :survey_id => @survey.id
      response.should redirect_to(survey_response_path(@survey, Response.last))
    end
  end

  describe "POST create" do
    before :each do
      @params = { :survey_id => @survey.id, :user_id => @user.id, :answers_attributes => [] }
    end
    describe "with valid params" do
      it "creates a new Response" do
        expect {
          post :create, {:survey_id => @survey.id, :response => @params}
        }.to change(Response, :count).by(1)
      end

      it "redirects to the created response" do
        post :create, {:survey_id => @survey.id, :response => @params}
        response.should redirect_to(survey_response_path(@survey, Response.last))
      end

      it "after redirecting to created response it should show thanks message" do
        post :create, {:survey_id => @survey.id, :response => @params}
        response.should redirect_to(survey_response_path(@survey, Response.last))
        flash[:notice].should_not be_blank
      end
    end
  end


  describe "GET show" do
    it "assigns the requested response as @response" do
      @params = { :survey_id => @survey.id, :user_id => @user.id, :answers_attributes => [] }
      response = Response.create! @params
      get :show, {:survey_id => @survey.id, :id => response.to_param}
      assigns(:response).should eq(response)
    end
  end

end
