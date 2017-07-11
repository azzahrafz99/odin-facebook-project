class UserMailer < ApplicationMailer
  default from: 'odinfacebook@mail.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Odin Facebook')
  end
end
