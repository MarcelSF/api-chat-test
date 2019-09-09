class ReplySerializer < ActiveModel::Serializer
  attributes :message, :session_id :reply_to, :locale_key, :created_at
end
