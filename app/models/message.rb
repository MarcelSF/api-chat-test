class Message < ApplicationRecord
  LANGUAGES = ['en', 'es', 'de']

  belongs_to :session
  validates :detected_language, presence: true, inclusion: { in: LANGUAGES }

  def broadcast_message(session)
    serialized_data = ActiveModelSerializers::Adapter::Json.new(
      MessageSerializer.new(self)
      ).serializable_hash
      MessagesChannel.broadcast_to session, serialized_data
  end

  def language_detection
    self.detected_language = CLD.detect_language(self.text)
    language[:code]
  end

  def set_identifier
    self.identifier = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.hex(10)
      break token unless Message.where(identifier: token).exists?
    end
  end
end
