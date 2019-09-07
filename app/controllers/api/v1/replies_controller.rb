class Api::V1::RepliesController < ApplicationController
  def index
    @replies = Reply.where("session_id = ?", params[:session_id]).order("created_at DESC")
    render json: @replies
  end

  def create
    reply = Reply.new(message_params)
    session = Session.find(reply_params[:session_id])
    if reply.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        ReplySerializer.new(reply)
      ).serializable_hash
      RepliesChannel.broadcast_to session, serialized_data
      head :ok
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:identifier, :session_id)
  end

end
