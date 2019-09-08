require 'rails_helper'
context 'Posting messages' do
  describe "Post a Message route - sucess", :type => :request do
    before do
      post '/api/v1/sessions/3/messages', params: { :text => 'Ich bin ein test' }
    end

    it 'returns the detected language' do
      expect(JSON.parse(response.body)['detected_language']).to eq('de')
    end

    it 'returns an identifier' do
      expect(JSON.parse(response.body)['identifier'].class).to be(Integer)
    end

    it 'returns a 201 status' do
      expect(response).to have_http_status(201)
    end
  end

   describe "Post a Message route - sucess", :type => :request do
    before do
      post '/api/v1/sessions/3/messages', params: { :text => 'Eu falo português' }
    end

    it 'returns the correct code' do
      expect(JSON.parse(response.body)['error']['code']).to eq(422)
    end

    it 'returns an error message' do
      expect(JSON.parse(response.body)['error']['message']).to eq("Unfortunately we don't have support for your language yet.")
    end

    it 'returns a 422 status' do
      expect(response).to have_http_status(422)
    end
  end
end
