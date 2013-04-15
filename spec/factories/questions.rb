FactoryGirl.define do
  factory :question do
    survey
    content "MyText"
    type 'EasyQuestion'

    factory :numeric_question do 
      type 'NumericQuestion'
    end

    factory :date_question do 
      type 'DateQuestion'
    end

    factory :invalid_question do 
      type 'InvalidQuestion'
    end
  end
end
