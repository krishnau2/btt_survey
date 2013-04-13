FactoryGirl.define do
  factory :survey do
    # expiry_date Date.today + 100.days
    sequence(:name) { |n| "name_#{n}" }
    description "MyText"
    status :false

    factory :survey_with_easy_questions do
      after(:create) do |survey, evaluator|
        FactoryGirl.create_list(:question, 5, :survey => survey)
      end
    end
    
    factory :survey_with_numeric_questions do
      after(:create) do |survey, evaluator|
        FactoryGirl.create_list(:numeric_question, 5, :survey => survey)
      end
    end
    
    factory :survey_with_date_questions do
      after(:create) do |survey, evaluator|
        FactoryGirl.create_list(:date_question, 5, :survey => survey)
      end
    end
        
    factory :survey_with_all_type_questions do
      after(:create) do |survey, evaluator|
        FactoryGirl.create_list(:question, 1, :survey => survey)
        FactoryGirl.create_list(:numeric_question, 1, :survey => survey)
        FactoryGirl.create_list(:date_question, 1, :survey => survey)
      end
    end

    # factory :survey_with_categories do
    #   after(:create) do |survey, evaluator|
    #     survey.finalize
    #     FactoryGirl.create_list(:category, 5, :survey => survey)
    #   end
    # end

    # factory :survey_with_all do
    #   ignore do
    #     options_count 5
    #   end
    #   after(:create) do |survey, evaluator|
    #     survey.finalize
    #     FactoryGirl.create_list(:question_with_answers, 5, :survey => survey)
    #     FactoryGirl.create_list(:category, 5, :survey => survey)
    #     question = survey.questions.first
    #     question.type = 'RadioQuestion' if question.type.blank?
    #     FactoryGirl.create_list(:option, evaluator.options_count, :question => question)
    #     question.save
    #     survey.save
    #   end
    # end
  end
end