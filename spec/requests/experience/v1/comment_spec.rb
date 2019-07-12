# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Comments API', type: :request do
  path '/experience/v1/comments/{id}' do
    put 'Update a Comment' do
      tags 'Comments'
      security [Bearer: []]
      consumes 'application/json'
      description 'Update a Comment'
      parameter name: :id, in: :path, type: :string, description: 'comment id', required: true
      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          comment: {
            type: :object,
            properties: {
              text: { type: :string, example: 'Comment' }
            },
            required: ['text']
          }
        }
      }

      response '200', 'Comment update' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/comment_objects'
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

      response '404', 'Comment Not Found' do
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

  path '/experience/v1/comments/{id}' do
    delete 'Delete a Comment' do
      tags 'Comments'
      security [Bearer: []]
      consumes 'application/json'
      description 'Delete a Comment'
      parameter name: :id, in: :path, type: :string, description: 'comment id', required: true

      response '204', 'Comment delete' do
        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref': '#/definitions/error_object'
        run_test!
      end

      response '404', 'Comment Not Found' do
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
