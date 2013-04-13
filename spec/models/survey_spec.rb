require 'spec_helper'

describe Survey do
  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :published_on }
  it { should respond_to :status }

  # it "should create with name krishna" do
		# s = FactoryGirl.build(:survey)
		# s.name.should be_eql 'krishna'
  # end

  context "when validating" do
  	it "should validate presence of name" do
  	  survey = Survey.create()
  	  survey.should_not be_valid
  	end
  end

  context "Creating survey " do
  	it "should create survey without associated questions" do
  	  survey = FactoryGirl.create(:survey)
  	  survey.questions_count.should be_eql 0
  	end

  	it "should create with associated question of type easy" do
  	  survey = FactoryGirl.create(:survey_with_easy_questions)
  	  survey.easy_questions.size.should be_eql 5
  	end
		
		it "should create with associated question of type numeric" do
  	  survey = FactoryGirl.create(:survey_with_numeric_questions)
  	  survey.numeric_questions.size.should be_eql 5
  	end
		
		it "should create with associated question of type date" do
  	  survey = FactoryGirl.create(:survey_with_date_questions)
  	  survey.date_questions.size.should be_eql 5
  	end

    it "should create with associated questions of all 3 types" do
      survey = FactoryGirl.create(:survey_with_all_type_questions)
      survey.questions_count.should be_eql 3
		end
  end

end
