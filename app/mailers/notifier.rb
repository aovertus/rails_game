class Notifier < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.email_friend.subject
  #
  def email_friend(game, sender_name, receiver_email)
    @game = game
    @sender_name = sender_name
   
    mail to: receiver_email, :subject => "Test this game !"
  end
  
  def sign_up_mail(user)
    @user = user
    mail to: @user.email, :subject => 'Welcome to Game Blog !'
  end
end
