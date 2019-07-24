# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /frontend_api/token', type: :request do
  let(:secret) { ENV['DEVISE_JWT_SECRET_KEY'] }
  let(:user) { Fabricate(:user) }
  let(:url) { '/frontend_api/token' }

  let(:params) do
    {
      email: user.email,
      password: user.password
    }
  end

  let(:bad_password) do
    {
      email: user.email,
      password: 'invalid_pw'
    }
  end

  let(:bad_user) do
    {
      email: 'idontexist',
      password: user.password
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

    it 'returns JWT token in authorization header' do
      expect(response.headers['HTTP_AUTHORIZATION']).to be_present
    end

    it 'returns valid JWT token' do
      expect { JWT.decode(response, secret) }.to_not raise_error(JWT::DecodeError)
    end
  end

  context 'when user does not exist' do
    before { post url, params: bad_user.to_json, headers: headers }

    it 'returns 404' do
      expect(response.status).to eq 404
    end
  end
end
