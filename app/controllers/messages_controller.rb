class MessagesController < ApplicationController
  require 'sendgrid-ruby'
  include SendGrid

  before_action :require_user

  def create
    message = current_user.messages.build(message_params)
    if message.save
      ActionCable.server.broadcast "chatroom_channel",
                                   mod_message: message_render(message)
      PostMailer.post_created.deliver_now
      from = SendGrid::Email.new(email: 'sorenessen@gmail.com')
      to = SendGrid::Email.new(email: 'grutherf@gmail.com')
      # to = SendGrid::Email.new(email: 'sorenessen@gmail.com')
      subject = 'New Activity in CatApp'
      content = SendGrid::Content.new(type: 'text/plain', value: 'Your friends are trying to reach you. Respond here: https://message-me-se.herokuapp.com/')
      mail = SendGrid::Mail.new(from, subject, to, content)

      sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
      response = sg.client.mail._('send').post(request_body: mail.to_json)
      puts response.status_code
      puts response.body
      puts response.parsed_body
      puts response.headers
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def message_render(message)
    render(partial: 'message', locals: {message: message})
  end

end