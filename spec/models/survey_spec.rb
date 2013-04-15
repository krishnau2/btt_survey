require 'spec_helper'

describe Survey do
  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :published_on }
  it { should respond_to :published }


  context "when validating" do
  	it "should validate presence of name" do
      survey = FactoryGirl.build(:survey, :name => nil)
  	  survey.should have(1).errors_on(:name)
  	end
  end

  context "Creating survey " do
    before :each do 
      @survey = FactoryGirl.create(:survey)
    end

  	it "should create survey without associated questions" do
  	  @survey.questions_count.should be_eql 0
  	end

  	it "should create with associated question of type easy" do
      FactoryGirl.create(:question, :survey => @survey)
      @survey.easy_questions.size.should be_eql 1
    end
    
    it "should create with associated question of type numeric" do
      FactoryGirl.create(:numeric_question, :survey => @survey)
      @survey.numeric_questions.size.should be_eql 1
    end
    
    it "should create with associated question of type date" do
      FactoryGirl.create(:date_question, :survey => @survey)
      @survey.date_questions.size.should be_eql 1
    end

    it "should create with associated questions of all 3 types" do
      FactoryGirl.create(:question, :survey => @survey)
      FactoryGirl.create(:numeric_question, :survey => @survey)
      FactoryGirl.create(:date_question, :survey => @survey)
      @survey.questions_count.should be_eql 3
		end
  end

end
