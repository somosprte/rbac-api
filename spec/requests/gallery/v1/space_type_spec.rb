# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Space types API', type: :request do
  path '/gallery/v1/space_types/' do
    get 'Get Space Types' do
      tags 'Space Types'
      consumes 'application/json'
      description 'Get Space Types'
      parameter name: :per, in: :query, type: :integer, description: 'results per page', default: 10, required: false
      parameter name: :page, in: :query, type: :integer, description: 'page', default: 1, required: false

      response '200', 'Space Types found' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/space_types_object'
                   }
                 },
                 links: {
                   type: :object,
                   properties: {
                     self: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/space_types/?page[number]=1&page[size]=10'
                     },
                     first: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/space_types/?page[number]=1&page[size]=10'
                     },
                     prev: {
                       type: :string,
                       format: :url,
                       example: nil
                     },
                     next: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/space_types/?page[number]=2&page[size]=10'
                     },
                     last: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/space_types/?page[number]=10&page[size]=10'
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

  path '/gallery/v1/space_types' do
    post 'Create a Space Type' do
      tags 'Space Types'
      security [Bearer: []]
      consumes 'application/json'
      description 'Create a Space Type'
      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          space_type: {
            type: :object,
            properties: {
              title: { type: :string, example: 'Sala de aula' },
              description: { type: :string, example: 'Sala de aula com projetor' }
            },
            required: ['title']
          }
        }
      }

      response '201', 'Space Type create' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/space_types_object'
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

  path '/gallery/v1/space_types/{id}' do
    put 'Update a Space Type' do
      tags 'Space Types'
      security [Bearer: []]
      consumes 'application/json'
      description 'Update a Space Type'
      parameter name: :id, in: :path, type: :string, description: 'space type id', required: true
      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          space_type: {
            type: :object,
            properties: {
              title: { type: :string, example: 'Sala de aula' },
              description: { type: :string, example: 'Sala de aula com projetor' }
            },
            required: ['title']
          }
        }
      }

      response '200', 'Space Type update' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/space_types_object'
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

      response '404', 'Space Type Not Found' do
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

  path '/gallery/v1/space_types/{id}' do
    get 'Get a Space Type' do
      tags 'Space Types'
      security [Bearer: []]
      consumes 'application/json'
      description 'Get a Space Type'
      parameter name: :id, in: :path, type: :string, description: 'space type id', required: true

      response '200', 'Space Type found' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/space_types_object'
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

      response '404', 'Space Type Not Found' do
        schema '$ref': '#/definitions/error_object'
        run_test!
      end

      response '500', 'Internal Server Error' do
        schema '$ref': '#/definitions/error_object'
        run_test!
      end
    end
  end

  path '/gallery/v1/space_types/{id}' do
    delete 'Delete a Space Type' do
      tags 'Space Types'
      security [Bearer: []]
      consumes 'application/json'
      description 'Delete a Space Type'
      parameter name: :id, in: :path, type: :string, description: 'space type id', required: true

      response '204', 'Space Type delete' do
        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref': '#/definitions/error_object'
        run_test!
      end

      response '404', 'Space Type Not Found' do
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
