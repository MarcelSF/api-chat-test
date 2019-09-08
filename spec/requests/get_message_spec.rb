require 'rails_helper'
context 'Getting Messages with Identifier' do
  describe "Get Message from a session with identifier - SUCCESS", :type => :request do
    def set_host (host)
      host! host
    end

    before(:each) do
      set_host "localhost:3000/"
    end

    before do
      post '/api/v1/sessions/3/messages', params: { :text => 'Ich bin ein test' }
      @identifier = JSON.parse(response.body)["identifier"]
      get "api/v1/sessions/3/messages/#{@identifier}"
    end

    it 'returns the correct message' do
      expect(JSON.parse(response.body)["identifier"]).to eq(@identifier)
    end

    it 'returns the detected_language' do
      expect(JSON.parse(response.body)["detected_language"]).to eq("de")
    end

    it 'returns a 200 status' do
       expect(response).to have_http_status(200)
    end
  end

  describe "Get Message from a session with identifier - ERROR", :type => :request do
    def generate_token
      loop do
        token = SecureRandom.hex(8)
        break token unless Message.where(identifier: token).exists?
      end
    end

    def set_host (host)
      host! host
    end

    before(:each) do
      set_host "localhost:3000/"
    end

    before do
      @identifier = generate_token
      get "api/v1/sessions/3/messages/#{@identifier}"
    end

    it 'returns the correct error message' do
      expect(JSON.parse(response.body)["error"]["message"]).to eq("Resource doesn't exist")
    end

    it 'returns a 404 status' do
      expect(response).to have_http_status(404)
    end
  end
end
