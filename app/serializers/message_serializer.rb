class MessageSerializer < ActiveModel::Serializer
  attributes :identifier, :session_id, :detected_language, :created_at
end
