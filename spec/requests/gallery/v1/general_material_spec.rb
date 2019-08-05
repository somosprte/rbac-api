# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'General Materials API', type: :request do
  path '/gallery/v1/general_materials/' do
    get 'Get General Materials' do
      tags 'General Materials'
      consumes 'application/json'
      description 'General Materials'
      parameter name: :per, in: :query, type: :integer, description: 'results per page', default: 10, required: false
      parameter name: :page, in: :query, type: :integer, description: 'page', default: 1, required: false

      response '200', 'General Materials found' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/general_materials_objects'
                   }
                 },
                 links: {
                   type: :object,
                   properties: {
                     self: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/general_materials/?page[number]=1&page[size]=10'
                     },
                     first: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/general_materials/?page[number]=1&page[size]=10'
                     },
                     prev: {
                       type: :string,
                       format: :url,
                       example: nil
                     },
                     next: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/general_materials/?page[number]=2&page[size]=10'
                     },
                     last: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/general_materials/?page[number]=10&page[size]=10'
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

  path '/gallery/v1/general_materials' do
    post 'Create a General Material' do
      tags 'General Materials'
      security [Bearer: []]
      consumes 'application/json'
      description 'Create a General Material'
      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          general_material: {
            type: :object,
            properties: {
              name: { type: :string, example: 'Cartolina' },
              description: { type: :string, example: 'Cartolina para ser usada em atividades' }
            },
            required: ['title']
          }
        }
      }

      response '201', 'General Material create' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/general_materials_objects'
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

  path '/gallery/v1/general_materials/{id}' do
    put 'Update a General Material' do
      tags 'General Materials'
      security [Bearer: []]
      consumes 'application/json'
      description 'Update a General Material'
      parameter name: :id, in: :path, type: :string, description: 'general material id', required: true
      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          general_material: {
            type: :object,
            properties: {
              name: { type: :string, example: 'Cartolina' },
              description: { type: :string, example: 'Cartolina para ser usada em atividades' }
            },
            required: ['title']
          }
        }
      }

      response '200', 'General Material update' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/general_materials_objects'
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

      response '404', 'General Material Not Found' do
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

  path '/gallery/v1/general_materials/{id}' do
    get 'Get a General Material' do
      tags 'General Materials'
      security [Bearer: []]
      consumes 'application/json'
      description 'Get a General Material'
      parameter name: :id, in: :path, type: :string, description: 'general material id', required: true

      response '200', 'General Material found' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/general_materials_object'
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

      response '404', 'General Material Not Found' do
        schema '$ref': '#/definitions/error_object'
        run_test!
      end

      response '500', 'Internal Server Error' do
        schema '$ref': '#/definitions/error_object'
        run_test!
      end
    end
  end

  path '/gallery/v1/general_materials/{id}' do
    delete 'Delete a General Material' do
      tags 'General Materials'
      security [Bearer: []]
      consumes 'application/json'
      description 'Delete a General Materia'
      parameter name: :id, in: :path, type: :string, description: 'general material id', required: true

      response '204', 'General Materia delete' do
        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref': '#/definitions/error_object'
        run_test!
      end

      response '404', 'General Materia Not Found' do
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
