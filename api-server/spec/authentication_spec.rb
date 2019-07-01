require 'rails_helper'

RSpec.describe 'POST /login', type: :request do
  let(:secret) { ENV['DEVISE_JWT_SECRET_KEY'] }
  let(:user) { Fabricate(:user) }
  let(:url) { '/api/users/sign_in' }
  let(:params) do
    {
      format: :json,
      user: {
        email: user.email,
        password: user.password
      }
    }
  end

  context 'when params are correct' do
    before do
      post url, params: params.to_json, headers: { 'Content-Type' => 'application/json' }
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns JTW token in authorization header' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns valid JWT token' do
      token = JSON.parse(response.body)['auth_token']
      expect { JWT.decode(response, secret) }.to_not raise_error(JWT::DecodeError)
    end
  end

  context 'when login params are incorrect' do
    before { post url }

    it 'returns unathorized status' do
      expect(response.status).to eq 401
    end
  end
end

RSpec.describe 'DELETE /logout', type: :request do
  let(:url) { '/api/users/sign_out' }

  it 'returns 204, no content' do
    delete url
    expect(response).to have_http_status(204)
  end
end
