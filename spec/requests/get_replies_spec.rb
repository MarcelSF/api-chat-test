require 'rails_helper'
context 'Getting replies' do
  describe "Get replies from a session route - SUCCESS", :type => :request do
    def set_host (host)
      host! host
    end

    before(:each) do
      set_host "localhost:3000/"
    end

    before do
      post '/api/v1/sessions/3/messages', params: { :text => 'Ich bin ein test' }
      post '/api/v1/sessions/3/messages', params: { :text => 'Ich bin ein test auch' }
      get 'api/v1/sessions/3/replies'
    end

    it 'returns the correct number of replies' do
      # binding.pry
      expect(JSON.parse(response.body).size).to eq(2)
    end

    it 'returns replies with the correct messages and the right order' do
      expect(JSON.parse(response.body)[0]["message"]).to eq("In Zukunft werde ich in der Lage sein, jede deiner Fragen zu beantworten")
      expect(JSON.parse(response.body)[1]["message"]).to eq("Hallo! Ich bin ein virtueller Assistent und ich bin hier, um zu helfen. Ich kann Ihnen auf Deutsch, Englisch oder Spanisch helfen.")
    end

    it 'returns replies with the correct locale_keys' do
      expect(JSON.parse(response.body)[0]["locale_key"]).to eq("de.after_salutation")
      expect(JSON.parse(response.body)[1]["locale_key"]).to eq("de.salutation")
    end

    it 'returns replies with an reply_to identifier' do
      expect(JSON.parse(response.body)[0]['reply_to'].class).to be(Integer)
    end
  end
end
