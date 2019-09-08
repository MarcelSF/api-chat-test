require 'rails_helper'
context 'Sessions test' do
  describe "get all sessions route", :type => :request do
    def set_host (host)
      host! host
    end

    before(:each) do
      set_host "localhost:3000/"
    end

    let!(:sessions) { FactoryBot.create_list(:session, 20)}

    before { get 'api/v1/sessions'}

    it 'returns all sessions' do
      expect(JSON.parse(response.body).size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end
