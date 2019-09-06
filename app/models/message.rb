class Message < ApplicationRecord
  LANGUAGES = ['en', 'es', 'de']

  belongs_to :session
  validates :detected_language, presence: true, inclusion: { in: LANGUAGES }
end
