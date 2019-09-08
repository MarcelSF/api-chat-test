require 'spec_helper'

RSpec.describe Message, type: :model do
  context ' Valid factory ' do
    it 'Has a valid factory' do
      session = create(:session)
      message = create(:message, session: session)
      expect(message).to be_valid
    end
  end

  context 'Validations' do
    it 'Belongs to a session' do
      session = create(:session)
      message = create(:message)
      expect(build(:message, session_id: nil)).to_not be_valid
    end

    it 'Has an identifier' do
      session = create(:session)
      message = create(:message)
      expect(build(:message, session: session, identifier: "")).to_not be_valid
    end

    it 'Has a blank text' do
      session = create(:session)
      message = create(:message)
      expect(build(:message, session: session, text: "An example of English")).to_not be_valid
    end

    it 'Has a valid detect_language code' do
      session = create(:session)
      message = create(:message)
      expect(build(:message, session: session, detected_language: "un")).to_not be_valid
      expect(build(:message, session: session, detected_language: "")).to_not be_valid
    end
  end
end
