class Api::V1::RepliesController < ApplicationController
  def index
    @replies = Reply.where("session_id = ?", params[:session_id]).order("created_at DESC")
    render json: @replies
  end

  def create
    @reply = Reply.new(reply_params)
    @reply.save
  end

  private

  def reply_params
    params.require(:reply).permit(:identifier, :session_id)
  end
end
