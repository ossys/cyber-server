# frozen_string_literal: true

require 'rails_helper'
require './spec/support/api_schema_matcher'

RSpec.describe 'POST /signup', type: :request do
  let(:url) { '/api/users' }
  let(:params) do
    {
      user: {
        email: 'user@example.com',
        password: 'password'
      }
    }
  end

  context 'when user is unauthenticated' do
    before { post url, params: params }

    it 'returns 201' do
      expect(response.status).to eq 201
    end

    it 'returns a new user' do
      expect(response).to match_response_schema('user_create')
    end
  end

  context 'when user already exists' do
    before do
      Fabricate :user, email: params[:user][:email]
      post url, params: params
    end

    it 'returns bad request status' do
      expect(response.status).to eq 400
    end

    it 'returns validation errors' do
      json = JSON.parse(response.body)

      expect(json['errors'].first['title']).to eq('Bad Request')
    end
  end
end
