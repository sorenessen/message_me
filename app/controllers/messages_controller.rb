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