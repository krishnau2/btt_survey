FactoryGirl.define do
  factory :question do
    content "MyText"
    survey_id { FactoryGirl.create(:survey).id }
    type 'EasyQuestion'

    factory :numeric_question do 
      type 'NumericQuestion'
    end

    factory :date_question do 
      type 'DateQuestion'
    end

    factory :invlaid_question do 
      type 'InvalidQuestion'
    end
    # sequence(:order_number, 1000)

    # factory :question_with_answers do
    #   after(:create) do |question, evaluator|
    #     FactoryGirl.create_list(:answer, 5, :question => question)
    #   end
    # end

    # factory :question_with_options do
    #   ignore do
    #     options_count 5
    #   end
    #   after(:create) do |question, evaluator|
    #     question.type = 'RadioQuestion' if question.type.blank?
    #     FactoryGirl.create_list(:option, evaluator.options_count, :question => question)
    #     question.save
    #   end
    # end

    # factory :question_with_image do
    #   after(:create) do |question, e|
    #     question.image = fixture_file_upload(Rails.root.to_s + '/spec/fixtures/images/sample.jpg', 'image/jpeg')
    #     question.save
    #   end
    # end
  end
end
