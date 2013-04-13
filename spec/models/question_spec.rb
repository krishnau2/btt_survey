require 'spec_helper'

describe Question do
  # pending "add some examples to (or delete) #{__FILE__}"
  	it { should respond_to :survey_id }
  	it { should respond_to :content }
  	it { should respond_to :type }

  context "when validationg" do
  	it "should validate precence of content" do
  	  question = Question.create(:survey_id => 1, :type => 'EasyQuestion')
  	  question.should_not be_valid
  	end

  	it "should validate precence of survey_id" do
  	  question = Question.create(:content => "test", :type => 'EasyQuestion')
  	  question.should_not be_valid
  	end

    it "should validate invalid question type" do
  	  question = FactoryGirl.build(:invlaid_question)
  	  question.should_not be_valid
  	end
  end
end
