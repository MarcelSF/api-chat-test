class MessagesChannel < ApplicationCable::Channel
  def subscribed
    session = Session.find(params[:session])
    stream_for session
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
