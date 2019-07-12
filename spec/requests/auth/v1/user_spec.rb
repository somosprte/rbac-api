# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Auth API', type: :request do
  path '/auth/v1/users/register' do
    post 'Create a User' do
      tags 'Auth'
      consumes 'application/json'
      description 'Create a User'
      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          auth: {
            type: :object,
            properties: {
              email: { type: :string, example: 'pedro123@gmail.com' },
              name: { type: :string, example: 'Pedro' },
              birthday: { type: :string, example: '1989-10-10' },
              password: { type: :string, example: '123456' }
            },
            required: %w[email name birthday password]
          }
        }
      }

      response '201', 'User create' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/people_object'
                   }
                 }
               },
               required: ['data']
        run_test!
      end

      response '400', 'Bad request' do
        schema '$ref': '#/definitions/error_object'
        run_test!
      end

      response '500', 'Internal Server Error' do
        schema '$ref': '#/definitions/error_object'
        run_test!
      end
    end
  end

  path '/auth/v1/users/login' do
    post 'Login API' do
      tags 'Auth'
      consumes 'application/json'
      description 'Login in API'
      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          auth: {
            type: :object,
            properties: {
              username: { type: :string, example: 'pedro123@gmail.com' },
              password: { type: :string, example: '123456' }
            },
            required: %w[username password]
          }
        }
      }

      response '200', 'Login Successful' do
        schema type: :object,
               properties: {
                 jwt: {
                   type: :string,
                   example: 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjoiMTI9OGI0OTYtYjk3NC00YWM10LWFiZGEtODlhZjZmYWUwMjgxIn0'
                 },
                 id: {
                   type: :string,
                   example: 'ad054857-3de0-484a-9c01-180344c00985'
                 }
               },
               required: ['jwt']
        run_test!
      end

      response '400', 'Bad request' do
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
