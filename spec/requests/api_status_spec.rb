require 'rails_helper'

RSpec.describe 'User Requests API Status', type: :request do
  describe 'GET api status' do
    before {
      get '/status',
          headers: invalid_headers
    }

    it 'returns status message' do
      expect(json_response[:status]).to_not be_nil
    end

    it 'returns :ok status code' do
      expect(response.status).to eql(200)
    end

  end
end
