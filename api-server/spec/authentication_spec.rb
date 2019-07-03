require 'rails_helper'

RSpec.describe 'POST /api/sign_in', type: :request do
  let(:secret) { ENV['DEVISE_JWT_SECRET_KEY'] }
  let(:user) { Fabricate(:user) }
  let(:url) { '/api/sign_in' }
  let(:params) do
    {
      user: {
        email: user.email,
        password: user.password
      }
    }
  end

  let(:headers) do
    {
      'Content-Type' => 'application/json' 
    }
  end


  context 'when params are correct' do
    before do
      post url, params: params.to_json, headers: headers
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns JTW token in authorization header' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns valid JWT token' do
      expect { JWT.decode(response, secret) }.to_not raise_error(JWT::DecodeError)
    end
  end

  context 'when login params are incorrect' do
    before { post url }

    it 'returns unathorized status' do
      expect(response.status).to eq 404
    end
  end
end
