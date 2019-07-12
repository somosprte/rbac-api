# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Implementations API', type: :request do
  path '/experience/v1/implementations/{id}' do
    put 'Update a Implementation' do
      tags 'Implementations'
      security [Bearer: []]
      consumes 'application/json'
      description 'Update a Comment'
      parameter name: :id, in: :path, type: :string, description: 'implementation id', required: true
      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          implementation: {
            type: :object,
            properties: {
              date_implementation: { type: :string, example: '2019-01-15' },
              place_implementation: { type: :string, example: 'MIT' },
              number_participants: { type: :integer, example: 10 },
              description: { type: :string, example: 'Implementação em classe' },
              person_ids: { type: :array, example: ['3b11f1db-e8c2-4379-beb7-0ba7f993e23a'] }
            }
          }
        }
      }

      response '200', 'Implementation update' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/implementation_objects'
                   }
                 }
               },
               required: ['data']
        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref': '#/definitions/error_object'
        run_test!
      end

      response '404', 'Implementation Not Found' do
        schema '$ref': '#/definitions/error_object'
        run_test!
      end

      response '422', 'Entity error' do
        schema '$ref': '#/definitions/error_object'
        run_test!
      end

      response '500', 'Internal Server Error' do
        schema '$ref': '#/definitions/error_object'
        run_test!
      end
    end
  end

  path '/experience/v1/implementations/{id}' do
    delete 'Delete a Implementation' do
      tags 'Implementations'
      security [Bearer: []]
      consumes 'application/json'
      description 'Delete a Implementation'
      parameter name: :id, in: :path, type: :string, description: 'implementation id', required: true

      response '204', 'Implementation delete' do
        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref': '#/definitions/error_object'
        run_test!
      end

      response '404', 'Implementation Not Found' do
        schema '$ref': '#/definitions/error_object'
        run_test!
      end

      response '500', 'Internal Server Error' do
        schema '$ref': '#/definitions/error_object'
        run_test!
      end
    end
  end
end
