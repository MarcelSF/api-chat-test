class Api::V1::MessagesController < ApplicationController

  def create
    message = Message.new(message_params.except(:text))
    session = Session.find(message_params[:session_id])
    message.identifier = generate_token
    message.detected_language = language_detection(message_params[:text])

    if message.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        MessageSerializer.new(message)
      ).serializable_hash
      MessagesChannel.broadcast_to session, serialized_data
      head :ok

      reply = Reply.new(message_params.except(:text))
      reply.locale_key = message.detected_language
      reply.reply_to = message.identifier
      broadcast_reply(reply) if reply.save
    else
      render :json => {error: { "code": 422,
      "message": "Unfortunately we don't have support for your language yet." }}, :status => 422
    end
  end

  private

  def set_identifier
    self.identifier = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.hex(10)
      break token unless Message.where(identifier: token).exists?
    end
  end

  def broadcast_reply(message)
    serialized_data = ActiveModelSerializers::Adapter::Json.new(
      ReplySerializer.new(message)
    ).serializable_hash
    RepliesChannel.broadcast_to session, serialized_data
    head :ok
  end

  def language_detection(text)
    language = CLD.detect_language(text)
    language[:code]
  end

  def message_params
    params.permit(:identifier, :session_id, :text)
  end
end
