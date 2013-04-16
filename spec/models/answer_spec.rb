require 'spec_helper'

describe Answer do
	it { should respond_to :content }
	it { should respond_to :response_id }
  it { should respond_to :question_id }

  context "when validating" do
  	before :each do 
  		@response = FactoryGirl.build(:response)
  	end

  	it "should be valid for valid data" do
  	  answer = FactoryGirl.build(:answer, {:response => @response})
  	  answer.should be_valid
  	end

    it "should validate precence of content" do
      answer = FactoryGirl.build(:answer_without_content, {:response => @response})
      answer.should have(1).errors_on(:content)
    end

    it "should validate precence of response" do
      answer = FactoryGirl.build(:answer_without_response)
      answer.should have(1).errors_on(:response)
    end

    it "should validate precence of question" do
      answer = FactoryGirl.build(:answer_without_question, {:response => @response})
      answer.should have(1).errors_on(:question)
    end

    context "based on question type (invalid answer)" do
      it "should validate numericality of answer for Numeric Question." do
        question = FactoryGirl.create(:numeric_question)
        answer = FactoryGirl.build(:answer,{:question => question, :response => @response })
        answer.should have(1).errors_on(:content)
      end

      it "should validate date format of answer for Date Question." do
        question = FactoryGirl.create(:date_question)
        answer = FactoryGirl.build(:answer, {:question => question, :response => @response })
        answer.should have(1).errors_on(:content)
      end
    end

    context "based on question type (valid answer)" do
      it "should accept numbers as answer for Numeric Question." do
        question = FactoryGirl.create(:numeric_question)
        answer = FactoryGirl.build(:numeric_answer,{:question => question, :response => @response })
        answer.should have(0).errors_on(:content)
      end

      it "should accept date(yyyy/mm/dd) as answer for Date Question." do
        question = FactoryGirl.create(:date_question)
        answer = FactoryGirl.build(:date_answer,{:question => question, :response => @response })
        answer.should have(0).errors_on(:content)
      end
    end
  end
end
