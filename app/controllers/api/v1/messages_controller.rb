class Api::V1::MessagesController < ApplicationController
  def create
    @message = Message.new(message_params.except(:text))
    @session = Session.find(message_params[:session_id])
    @message.set_identifier
    @message.detected_language = language_detection(message_params[:text])

    if @message.save
      @message.broadcast_message(@session)
      @reply = Reply.new(message_params.except(:text))
      @reply.locale_key = @message.detected_language
      @reply.reply_to = @message.identifier
      broadcast_reply(@reply) if @reply.save
    else
      render :json => {error: { "code": 422,
      "message": "Unfortunately we don't have support for your language yet." }}, :status => 422
    end
  end

  def show
    if @message = Message.find_by_identifier(params[:id])
      render json: @message
    else
      render :json => {error: { "code": 404,
      "message": "Resource doesn't exist" }}, :status => 404
    end
  end

  private

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
