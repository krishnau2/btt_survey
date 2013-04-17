require 'spec_helper'

describe SurveysController do

  # This should return the minimal set of attributes required to create a valid
  # Survey. As you add validations to Survey, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "name" => "MyString" }
  end

  before :each do 
    user_params = {:user_name => "test", :email => "test@gmail.com", :password => "kk", :password_confirmation => "kk"}
    @user = User.create(user_params)
    @user.update_attribute(:verified, true)
    @user.update_attribute(:admin, true)
    session[:user_id] = @user.id
    session[:admin] = true if @user.admin?
  end

  describe "Non-Admin user" do
    before :each do
      user_params = {:user_name => "non-admin", :email => "non-admin@gmail.com", :password => "kk", :password_confirmation => "kk"}
      @user = User.create(user_params)
      @user.update_attribute(:verified, true)
      session[:user_id] = @user.id
      session[:admin] = nil 
    end
    describe "GET index" do
      it "should redirect to root path" do
        get :index
        response.should redirect_to root_path
      end

      it "should show Access restricted in flash" do
        get :index
        flash[:notice].should be_eql "Access restricted"
      end
    end
    describe "GET show" do
      it "should redirect to root path" do
        survey = Survey.create! valid_attributes
        get :show, {:id => survey.to_param}
        response.should redirect_to root_path
      end

      it "should show Access restricted in flash" do
        survey = Survey.create! valid_attributes
        get :show, {:id => survey.to_param}
        flash[:notice].should be_eql "Access restricted"
      end
    end
    describe "GET new" do
      it "should redirect to root path" do
        get :new
        response.should redirect_to root_path
      end

      it "should show Access restricted in flash" do
        get :new
        flash[:notice].should be_eql "Access restricted"
      end
    end
    describe "GET edit" do
      it "should redirect to root path" do
        survey = Survey.create! valid_attributes
        get :edit, {:id => survey.to_param}
        response.should redirect_to root_path
      end

      it "should show Access restricted in flash" do
        survey = Survey.create! valid_attributes
        get :edit, {:id => survey.to_param}
        flash[:notice].should be_eql "Access restricted"
      end
    end
    describe "POST create" do
      it "should redirect to root path" do
        post :create, {:survey => valid_attributes}
        response.should redirect_to root_path
      end

      it "should show Access restricted in flash" do
        post :create, {:survey => valid_attributes}
        flash[:notice].should be_eql "Access restricted"
      end
    end
    describe "PUT update" do
      it "should redirect to root path" do
        survey = Survey.create! valid_attributes
        put :update, {:id => survey.to_param, :survey => valid_attributes}
        response.should redirect_to root_path
      end

      it "should show Access restricted in flash" do
        survey = Survey.create! valid_attributes
        put :update, {:id => survey.to_param, :survey => valid_attributes}
        flash[:notice].should be_eql "Access restricted"
      end
    end
    describe "DELETE destroy" do
      it "should redirect to root path" do
        survey = Survey.create! valid_attributes
        delete :destroy, {:id => survey.to_param}
        response.should redirect_to root_path
      end

      it "should show Access restricted in flash" do
        survey = Survey.create! valid_attributes
        delete :destroy, {:id => survey.to_param}
        flash[:notice].should be_eql "Access restricted"
      end
    end

  end

  describe "GET index" do
    it "assigns all surveys as @surveys" do
      survey = Survey.create! valid_attributes
      get :index
      assigns(:surveys).should eq([survey])
    end
  end

  describe "GET show" do
    it "assigns the requested survey as @survey" do
      survey = Survey.create! valid_attributes
      get :show, {:id => survey.to_param}
      assigns(:survey).should eq(survey)
    end
  end

  describe "GET new" do
    it "assigns a new survey as @survey" do
      get :new
      assigns(:survey).should be_a_new(Survey)
    end
  end

  describe "GET edit" do
    it "assigns the requested survey as @survey" do
      survey = Survey.create! valid_attributes
      get :edit, {:id => survey.to_param}
      assigns(:survey).should eq(survey)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Survey" do
        expect {
          post :create, {:survey => valid_attributes}
        }.to change(Survey, :count).by(1)
      end

      it "assigns a newly created survey as @survey" do
        post :create, {:survey => valid_attributes}
        assigns(:survey).should be_a(Survey)
        assigns(:survey).should be_persisted
      end

      it "redirects to the created survey" do
        post :create, {:survey => valid_attributes}
        response.should redirect_to(Survey.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved survey as @survey" do
        # Trigger the behavior that occurs when invalid params are submitted
        Survey.any_instance.stub(:save).and_return(false)
        post :create, {:survey => { "name" => "invalid value" }}
        assigns(:survey).should be_a_new(Survey)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Survey.any_instance.stub(:save).and_return(false)
        post :create, {:survey => { "name" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested survey" do
        survey = Survey.create! valid_attributes
        # Assuming there are no other surveys in the database, this
        # specifies that the Survey created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Survey.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
        put :update, {:id => survey.to_param, :survey => { "name" => "MyString" }}
      end

      it "assigns the requested survey as @survey" do
        survey = Survey.create! valid_attributes
        put :update, {:id => survey.to_param, :survey => valid_attributes}
        assigns(:survey).should eq(survey)
      end

      it "redirects to the survey" do
        survey = Survey.create! valid_attributes
        put :update, {:id => survey.to_param, :survey => valid_attributes}
        response.should redirect_to(survey)
      end
    end

    describe "with invalid params" do
      it "assigns the survey as @survey" do
        survey = Survey.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Survey.any_instance.stub(:save).and_return(false)
        put :update, {:id => survey.to_param, :survey => { "name" => "invalid value" }}
        assigns(:survey).should eq(survey)
      end

      it "re-renders the 'edit' template" do
        survey = Survey.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Survey.any_instance.stub(:save).and_return(false)
        put :update, {:id => survey.to_param, :survey => { "name" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested survey" do
      survey = Survey.create! valid_attributes
      expect {
        delete :destroy, {:id => survey.to_param}
      }.to change(Survey, :count).by(-1)
    end

    it "redirects to the surveys list" do
      survey = Survey.create! valid_attributes
      delete :destroy, {:id => survey.to_param}
      response.should redirect_to(surveys_url)
    end
  end

end
