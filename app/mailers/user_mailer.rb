class UserMailer < ActionMailer::Base
  default from: "verification@survey.com"

  def verify_email(user)
  	@user = user
  	@url = "#{HOST}/verification/#{@user.email_verification_token}"
  	mail(:to => user.email, :subject => "Email verification")
  end
end
