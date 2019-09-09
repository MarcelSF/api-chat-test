class Api::V1::MessagesController < ApplicationController
  def create
    if Session.exists?(:id => message_params[:session_id])
      @session = Session.find(message_params[:session_id])
    else
      @session = Session.create(:id => message_params[:session_id])
    end

    @message = Message.new(message_params)
    @message.set_identifier
    @message.detect_language

    if @message.save
      @reply = Reply.new
      @reply.build_reply(@message, @session)
      @reply.save
      render json: @message, :status => 201
    else
      render :json => {error: { "code": 422,
      "message": "Unfortunately we don't have support for your language yet." }}, :status => 422
    end
  end

  def show
    if @message = Message.find_by_identifier(params[:id])
      if @message.session_id == params[:session_id].to_i
        render json: @message, status: 200
      else
        render :json => {error: { "code": 404,
        "message": "Resource doesn't exist" }}, :status => 404
      end
    else
      render :json => {error: { "code": 404,
      "message": "Resource doesn't exist" }}, :status => 404
    end
  end

  private

  def message_params
    params.permit(:identifier, :session_id, :text)
  end
end
