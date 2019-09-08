FactoryBot.define do
  factory :reply do
    association :session, factory: :session, strategy: :build
    reply_to { 123 }
    locale_key { "en.salutation" }
    message { "Hello, how can I help you? I can help you in German, English or Spanish." }
  end
end
