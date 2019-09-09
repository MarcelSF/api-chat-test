class Reply < ApplicationRecord
  REPLIES = {
    "de" => {
      salutation: "Hallo! Ich bin ein virtueller Assistent und ich bin hier, um zu helfen. Ich kann Ihnen auf Deutsch, Englisch oder Spanisch helfen.",
      after_salutation: "In Zukunft werde ich in der Lage sein, jede deiner Fragen zu beantworten"
    },
    "en" => {
      salutation: "Hello! I am a virtual assistant and I am here to help. I can help you in German, English or Spanish.",
      after_salutation: "In the future, I will be able to answer any of your questions"
    },
    "es" => {
      salutation: "Hola! Soy un asistente virtual y estoy aquí para ayudar. Puedo entenderle en alemán, inglés o español.",
      after_salutation: "En el futuro, podré responder cualquiera de sus preguntas"
    }
  }

  CODES = ["de.salutation", "de.after_salutation", "en.salutation", "en.after_salutation", "es.salutation", "es.after_salutation"]

  belongs_to :session
  validates :message, presence: true
  validates :reply_to, presence: true
  validates :session, presence: true
  validates :locale_key, presence: true, inclusion: { in: CODES }

  def build_reply(message, session)
    message == session.messages.first ? (message_code = :salutation) : (message_code = :after_salutation)
    self.reply_to = message.identifier
    self.session_id = message.session_id
    self.message = REPLIES[message.detected_language][message_code]
    self.locale_key = "#{message.detected_language}.#{message_code}"
  end
end
