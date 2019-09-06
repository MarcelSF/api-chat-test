class Api::V1::SessionsController < ApplicationController
  def index
    sessions = Session.all
    render json: sessions
  end

  def create
    session = Session.new
    if session.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        SessionSerializer.new(session)
      ).serializable_hash
      ActionCable.server.broadcast 'sessions_channel', serialized_data
      head :ok
    end
  end

  private

end
