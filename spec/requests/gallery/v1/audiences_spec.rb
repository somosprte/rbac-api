# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Audiences API', type: :request do
  path '/gallery/v1/audiences/' do
    get 'Get Audiences' do
      tags 'Audiences'
      consumes 'application/json'
      description 'Get Audiences'
      parameter name: :per, in: :query, type: :integer, description: 'results per page', default: 10, required: false
      parameter name: :page, in: :query, type: :integer, description: 'page', default: 1, required: false

      response '200', 'Audiences found' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/audiences_object'
                   }
                 },
                 links: {
                   type: :object,
                   properties: {
                     self: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/audiences?page[number]=1&page[size]=10'
                     },
                     first: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/audiences?page[number]=1&page[size]=10'
                     },
                     prev: {
                       type: :string,
                       format: :url,
                       example: nil
                     },
                     next: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/audiences?page[number]=2&page[size]=10'
                     },
                     last: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/audiences?page[number]=10&page[size]=10'
                     }
                   },
                   required: %w[self first last]
                 },
                 meta: {
                   '$ref': '#/definitions/meta_pagination_object'
                 }
               },
               required: %w[data links meta]
        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref': '#/definitions/error_object'
        run_test!
      end

      response '500', 'Internal Server Error' do
        schema '$ref': '#/definitions/error_object'
        run_test!
      end
    end
  end

  path '/gallery/v1/audiences' do
    post 'Create a Audience' do
      tags 'Audiences'
      security [Bearer: []]
      consumes 'application/json'
      description 'Create a Audience'
      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          audience: {
            type: :object,
            properties: {
              name: { type: :string, example: 'Crianças' },
              description: { type: :string, example: 'Crianças' }
            },
            required: ['name']
          }
        }
      }

      response '201', 'Audience create' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/audiences_object'
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

  path '/gallery/v1/audiences/{id}' do
    put 'Update a Audience' do
      tags 'Audiences'
      security [Bearer: []]
      consumes 'application/json'
      description 'Update a Audience'
      parameter name: :id, in: :path, type: :string, description: 'audience id', required: true
      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          scope: {
            type: :object,
            properties: {
              name: { type: :string, example: 'Crianças' },
              description: { type: :string, example: 'Crianças' }
            },
            required: ['name']
          }
        }
      }

      response '200', 'Audience update' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/audiences_object'
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

      response '404', 'Audience Not Found' do
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

  path '/gallery/v1/audiences/{id}' do
    get 'Get a Audience' do
      tags 'Audiences'
      security [Bearer: []]
      consumes 'application/json'
      description 'Get a Audience'
      parameter name: :id, in: :path, type: :string, description: 'audience id', required: true

      response '200', 'Audience found' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/audiences_object'
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

      response '404', 'Audience Not Found' do
        schema '$ref': '#/definitions/error_object'
        run_test!
      end

      response '500', 'Internal Server Error' do
        schema '$ref': '#/definitions/error_object'
        run_test!
      end
    end
  end

  path '/gallery/v1/audiences/{id}' do
    delete 'Delete a Audience' do
      tags 'Audiences'
      security [Bearer: []]
      consumes 'application/json'
      description 'Delete a Audience'
      parameter name: :id, in: :path, type: :string, description: 'audience id', required: true

      response '204', 'Audience delete' do
        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref': '#/definitions/error_object'
        run_test!
      end

      response '404', 'Audience Not Found' do
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
