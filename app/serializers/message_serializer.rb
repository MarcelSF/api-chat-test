class MessageSerializer < ActiveModel::Serializer
  attributes :identifier, :detected_language, :created_at
end
