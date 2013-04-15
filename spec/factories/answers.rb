# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    # response_id {FactoryGirl.create(:response_with_answers_for_easy_question).id}
    response
    question
    content "MyText"

    factory :answer_without_content do
    	content nil
    end

    factory :answer_without_response do
    	response nil
    end
		
		factory :answer_without_question do
    	question nil
    end

    factory :numeric_answer do 
      content 99
    end

    factory :date_answer do 
      content "2013/04/14"
    end

  end
end
