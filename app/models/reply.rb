class Reply < ApplicationRecord
  REPLIES = {
    "de" => {
      salutation: "Hallo, Wie kann ich Ihnen helfen? Ich kann Ihnen auf Deutsch, Englisch oder Spanisch helfen.",
      after_salutation: "In Zukunft werde ich in der Lage sein, jede deiner Fragen zu beantworten"
    },
    "en" => {
      salutation: "Hello, how can I help you? I can help you in German, English or Spanish.",
      after_salutation: "In the future, I will be able to answer any of your questions"
    },
    "es" => {
      salutation: "Hola, ¿en qué puedo ayudarle? Puedo entenderle en alemán, inglés o español.",
      after_salutation: "En el futuro, podré responder cualquiera de sus preguntas"
    }
  }

  belongs_to :session
  validates :reply_to, presence: true
  validates :session_id, presence: true

  def build_reply(message, session)
    message == session.messages.first ? (message_code = :salutation) : (message_code = :after_salutation)
    self.reply_to = message.identifier
    self.session_id = message.session_id
    self.message = REPLIES[message.detected_language][message_code]
    self.locale_key = "#{message.detected_language}.#{message_code}"
  end
end
