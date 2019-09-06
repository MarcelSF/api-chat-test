class ReplySerializer < ActiveModel::Serializer
  attributes :message, :reply_to, :locale_key, :created_at
end
