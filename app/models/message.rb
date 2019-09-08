class Message < ApplicationRecord
  LANGUAGES = ['en', 'es', 'de']

  belongs_to :session
  validate :text_must_be_blank
  validates :identifier, presence: true, uniqueness: true
  validates :session, presence: true
  validates :detected_language, presence: true, inclusion: { in: LANGUAGES }

  def broadcast_message(session)
    serialized_data = ActiveModelSerializers::Adapter::Json.new(
      MessageSerializer.new(self)
    ).serializable_hash
    MessagesChannel.broadcast_to session, serialized_data
  end

  def text_must_be_blank
    if text != ""
      errors.add(:message, "Text must be blank")
    end
  end

  def detect_language
    self.detected_language = CLD.detect_language(self.text)[:code]
    self.text = ""
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
