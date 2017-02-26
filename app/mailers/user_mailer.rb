class UserMailer < ApplicationMailer
  default from: 'loganpgingerich@gmail.com'

  def welcome_email(user)
    @user = user
    @url  = 'https://floating-sands-93807.herokuapp.com/'
    mail(to: @user.email, subject: 'Welcome to Blocmarks')
  end
end
