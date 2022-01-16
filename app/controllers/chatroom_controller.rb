class ChatroomController < ApplicationController
  before_action :require_user

  def index
    @message = Message.new
    @messages = Message.custom_display
    PostMailer.post_created.deliver_later
  end

end
