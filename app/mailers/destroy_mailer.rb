class DestroyMailer < ActionMailer::Base
  default from: "from@example.com"

  def goodbye_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Your gone buddy')
  end
end
