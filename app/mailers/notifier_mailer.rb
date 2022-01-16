class NotifierMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier_mailer.post_mailer.subject
  #
  def post_mailer
    @greeting = "Hi"

    mail to: "sorenessen@gmail.com"
  end
end
