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
   
  end
end
