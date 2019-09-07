require 'spec_helper'

RSpec.describe Message, type: :model do
  context ' Valid factory ' do
    it 'Has a valid factory' do
      session = create(:session)
      message = create(:message, session: session)
      expect(build(:message, session_id: session.id)).to be_valid
    end
  end
end
