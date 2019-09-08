require 'spec_helper'

RSpec.describe Reply, type: :model do
  context ' Valid factory ' do
    it 'Has a valid factory' do
      session = create(:session)
      reply = create(:reply, session: session)
      expect(reply).to be_valid
    end
  end

  context 'Validations' do
    it 'Belongs to a session' do
      reply = create(:reply)
      expect(build(:reply, session_id: nil)).to_not be_valid
    end

    it 'Has an reply_to identifier' do
      session = create(:session)
      reply = create(:reply)
      expect(build(:reply, session: session, reply_to: nil)).to_not be_valid
    end

    it 'Has a valid locale_key' do
      session = create(:session)
      reply = create(:reply)
      expect(build(:reply, session: session, locale_key: "de.salutation")).to be_valid
      expect(build(:reply, session: session, locale_key: "pt.salutation")).to_not be_valid
    end

    it 'Has a valid detect_language code' do
      session = create(:session)
      reply = create(:reply)
      expect(build(:reply, session: session, message: "")).to_not be_valid
    end
  end
end
