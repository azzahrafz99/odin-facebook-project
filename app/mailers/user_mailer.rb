class UserMailer < ApplicationMailer
  default from: 'odinfacebool@mail.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Odin Facebook')
  end
end
