class Session < ApplicationRecord
  has_many :messages
  has_many :replies

  def broadcast
    serialized_data = ActiveModelSerializers::Adapter::Json.new(
      ConversationSerializer.new(self)
    ).serializable_hash
    ActionCable.server.broadcast 'sessions_channel', serialized_data
    head :ok
  end
end
