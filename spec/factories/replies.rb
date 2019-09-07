FactoryBot.define do
  factory :reply do
    association :session, factory: :session, strategy: :build
    reply_to {}
    locale_key {}
    session_id {}
    message {}
    session { nil }
  end
end
