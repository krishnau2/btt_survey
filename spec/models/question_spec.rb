require 'spec_helper'

describe Question do
  it { should respond_to :survey_id }
	it { should respond_to :content }
	it { should respond_to :type }

  context "when validationg" do
  	it "should validate precence of content" do
      question = FactoryGirl.build(:question, :content => nil)
      question.should have(1).errors_on(:content)
    end

    it "should validate precence of survey" do
      question = FactoryGirl.build(:question, :survey => nil)
  	  question.should have(1).errors_on(:survey)
  	end

    it "should validate invalid question type" do
  	  question = FactoryGirl.build(:invalid_question)
  	  question.should have(1).errors_on(:type)
  	end
  end

  context "creating question" do
    context "EasyQuestion" do
      before :each do
        @question = FactoryGirl.create(:question)
      end

      it "should be valid" do
        @question.should be_valid
      end

      it "should be of type EasyQuestion" do
        @question.type.should be_eql 'EasyQuestion'
      end
    end
    context "NumericQuestion" do
      before :each do
        @question = FactoryGirl.create(:numeric_question)
      end

      it "should be valid" do
        @question.should be_valid
      end

      it "should be of type EasyQuestion" do
        @question.type.should be_eql 'NumericQuestion'
      end
    end
    context "DateQuestion" do
      before :each do
        @question = FactoryGirl.create(:date_question)
      end

      it "should be valid" do
        @question.should be_valid
      end

      it "should be of type EasyQuestion" do
        @question.type.should be_eql 'DateQuestion'
      end
    end
  end
end
