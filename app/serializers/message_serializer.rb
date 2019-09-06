class MessageSerializer < ActiveModel::Serializer
  attributes :id, :identifier, :detected_language, :session_id, :created_at
end
