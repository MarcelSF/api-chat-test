class ReplySerializer < ActiveModel::Serializer
  attributes :id, :message, :reply_to, :locale_key, :session_id, :created_at
end
