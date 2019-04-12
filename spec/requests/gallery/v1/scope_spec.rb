require 'rails_helper'
require 'swagger_helper'


RSpec.describe 'Scopes API', type: :request do
    path '/gallery/v1/scopes/' do
        get "Get Scopes" do
            tags 'Scopes'
            #security [ Bearer: [] ]
            consumes 'application/json'
            description "Get Scopes"      
            parameter name: :per, :in => :query, :type => :integer, :description => 'results per page', :default => 10, required: false
            parameter name: :page, :in => :query, :type => :integer, :description => 'page', :default => 1, required: false

            response '200', 'Scopes found' do
                schema type: :object,
                    properties: {
                        data: {
                            type: :array,
                            items: {
                                '$ref': '#/definitions/scopes_object'
                            } 
                        },
                        links: {
                            type: :object,
                            properties: {
                            self: {
                                type: :string,
                                format: :url,
                                example: "//gallery/v1/scopes?page[number]=1&page[size]=10"
                            },
                            first: {
                                type: :string,
                                format: :url,
                                example: "//gallery/v1/scopes?page[number]=1&page[size]=10"
                            },
                            prev: {
                                type: :string,
                                format: :url,
                                example: nil
                            },
                            next: {
                                type: :string,
                                format: :url,
                                example: "//gallery/v1/scopes?page[number]=2&page[size]=10"
                            },
                            last: {
                                type: :string,
                                format: :url,
                                example: "//gallery/v1/scopes?page[number]=10&page[size]=10"
                            }
                            },
                            required: [ 'self', 'first', 'last']
                        },
                        meta: {
                            '$ref': '#/definitions/meta_pagination_object'
                        }
                    },
                    required: ["data", "links", "meta"] 
                run_test!
            end
            
            response '500', 'Internal Server Error' do
                run_test!
            end
            
        end
    end

    path '/gallery/v1/scopes/{id}' do
        get "Get a Scope" do
            tags 'Scopes'
            #security [ Bearer: [] ]
            consumes 'application/json'
            description "Get a Scope"      
            parameter name: :id, :in => :path, :type => :string, :description => 'scope id', required: true
  
            response '200', 'Scope found' do
                schema type: :object,
                    properties: {
                        data: {
                            type: :array,
                            items: {
                                '$ref': '#/definitions/scopes_object'
                            } 
                        }
                    },
                    required: ["data"] 
                run_test!
            end
  
  
            response '404', 'Scope Not Found' do
                let(:id) { 'invalid' }
                run_test!
            end
            
            response '500', 'Internal Server Error' do
                let(:id) { 'invalid' }
                run_test!
            end
            
        end
    end
end