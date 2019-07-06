# frozen_string_literal: true

# spec/integration/blogs_spec.rb
require 'swagger_helper'

describe 'Configs API' do
  path '/api/configs' do
    get 'Gets config index' do
      tags 'Configs'
      consumes 'application/json'

      response '200', 'configs index' do
        run_test!
      end
    end

    post 'Creates a config' do
      tags 'Configs'
      consumes 'application/json'
      parameter name: :config, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          data: { type: 'object' }
        },
        required: %w[name data]
      }

      response '201', 'config created' do
        let(:config) { { name: 'TestConf', data: { options: '{}' } } }
        run_test!
      end

      response '400', 'invalid request' do
        let(:config) { { name: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/configs/{id}' do
    get 'Retrieves a config' do
      tags 'Configs'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'config found' do
        schema type: :object,
               properties: {
                 data: {
                   type: :object,
                   id: { type: :integer, required: true },
                   name: { type: :string, required: true },
                   data: { type: 'object', required: true },
                   created_at: { type: :string, required: true },
                   updated_at: { type: :string, required: true }
                 }
               }

        let(:id) { Config.create(name: 'foo', data: { options: '{}' }).id }
        run_test!
      end

      response '404', 'config not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    delete 'Deletes a config' do
      tags 'Configs'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '204', 'config not found' do
        let(:id) { Config.create(name: 'foo', data: { options: '{}' }).id }
        run_test!
      end

      response '404', 'config not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
