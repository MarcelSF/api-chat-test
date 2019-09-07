class Reply < ApplicationRecord
  replies = {
    de: {
      salutation: "Hallo, Wie kann ich Ihnen helfen?",
      available_languages: "Ich kann Ihnen auf Deutsch, Englisch oder Spanisch helfen."
    }
  }

  belongs_to :session
end
