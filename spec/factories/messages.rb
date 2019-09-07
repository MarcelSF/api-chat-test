FactoryBot.define do
  factory :message do
    association :session, factory: :session, strategy: :build
    identifier { 123 }
    detected_language { "en" }
    text {"An example of English"}
  end
end
