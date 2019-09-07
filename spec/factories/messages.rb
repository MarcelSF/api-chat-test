FactoryBot.define do
  factory :message do
    association :session, factory: :session, strategy: :build
    identifier {}
    detected_language {}
    session_id { nil }
    text {}
  end
end
