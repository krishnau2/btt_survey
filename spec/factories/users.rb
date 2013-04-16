# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	sequence(:user_name) { |n| "name_#{n}" }
  	sequence(:email) { |n| "name_#{n}@mystring.com" }
  	password "my_password"
  	password_confirmation "my_password"
    password_hash ""
    password_salt ""
    email_verification_token ""
    verified false
    admin false
  end
end


