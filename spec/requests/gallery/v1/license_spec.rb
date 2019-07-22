# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Licenses API', type: :request do
  path '/gallery/v1/licenses/' do
    get 'Get Licenses' do
      tags 'Licenses'
      consumes 'application/json'
      description 'Get Licenses'
      parameter name: :per, in: :query, type: :integer, description: 'results per page', default: 10, required: false
      parameter name: :page, in: :query, type: :integer, description: 'page', default: 1, required: false

      response '200', 'Licenses found' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/licenses_object'
                   }
                 },
                 links: {
                   type: :object,
                   properties: {
                     self: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/licenses?page[number]=1&page[size]=10'
                     },
                     first: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/licenses?page[number]=1&page[size]=10'
                     },
                     prev: {
                       type: :string,
                       format: :url,
                       example: nil
                     },
                     next: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/licenses?page[number]=2&page[size]=10'
                     },
                     last: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/licenses?page[number]=10&page[size]=10'
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

  path '/gallery/v1/licenses' do
    post 'Create a License' do
      tags 'Licenses'
      security [Bearer: []]
      consumes 'application/json'
      description 'Create a License'
      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          license: {
            type: :object,
            properties: {
              title: { type: :string, example: 'License 1' },
              acronym: { type: :string, example: 'L1' },
              version: { type: :string, example: 'v1' },
              description: { type: :string, example: 'Scope 1' },
              external_link: { type: :string, example: 'www.domain.com' }
            },
            required: ['title', 'description']
          }
        }
      }

      response '201', 'License create' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/licenses_object'
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

  path '/gallery/v1/licenses/{id}' do
    put 'Update a License' do
      tags 'Licenses'
      security [Bearer: []]
      consumes 'application/json'
      description 'Update a License'
      parameter name: :id, in: :path, type: :string, description: 'license id', required: true
      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          license: {
            type: :object,
            properties: {
              title: { type: :string, example: 'License 1' },
              acronym: { type: :string, example: 'L1' },
              version: { type: :string, example: 'v1' },
              description: { type: :string, example: 'Scope 1' },
              external_link: { type: :string, example: 'www.domain.com' }
            },
            required: ['title']
          }
        }
      }

      response '200', 'License update' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/licenses_object'
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

      response '404', 'License Not Found' do
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

  path '/gallery/v1/licenses/{id}' do
    get 'Get a License' do
      tags 'Licenses'
      security [Bearer: []]
      consumes 'application/json'
      description 'Get a License'
      parameter name: :id, in: :path, type: :string, description: 'license id', required: true

      response '200', 'License found' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/licenses_object'
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

      response '404', 'License Not Found' do
        schema '$ref': '#/definitions/error_object'
        run_test!
      end

      response '500', 'Internal Server Error' do
        schema '$ref': '#/definitions/error_object'
        run_test!
      end
    end
  end

  path '/gallery/v1/licenses/{id}' do
    delete 'Delete a License' do
      tags 'Licenses'
      security [Bearer: []]
      consumes 'application/json'
      description 'Delete a License'
      parameter name: :id, in: :path, type: :string, description: 'license id', required: true

      response '204', 'License delete' do
        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref': '#/definitions/error_object'
        run_test!
      end

      response '404', 'License Not Found' do
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
