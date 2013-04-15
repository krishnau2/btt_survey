require 'spec_helper'

describe Response do
	it { should respond_to :survey_id }
	it { should respond_to :user_id }

	context "when validating" do
		it "should validate presence of survey_id" do
		  response = FactoryGirl.build(:response, :survey => nil)
		  response.should have(1).errors_on(:survey)
		end
	end

	context "creating response" do
		before :each do 
			@response = FactoryGirl.create(:response)
		end

	  it "should create a response with answers" do
	  	answer = FactoryGirl.create(:answer, {:response => @response})
	    @response.answers.size.should be_eql 1
	  end

	  it "should create a response with numeric answers" do
	  	answer = FactoryGirl.create(:numeric_answer, {:response => @response})
	    @response.answers.size.should be_eql 1
	  end

	  it "should create a response with date answers" do
	  	answer = FactoryGirl.create(:date_answer, {:response => @response})
	    @response.answers.size.should be_eql 1
	  end
	end

end
