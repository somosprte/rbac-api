require 'rails_helper'
require 'swagger_helper'


RSpec.describe 'Audiences API', type: :request do
    path '/gallery/v1/audiences/' do
        get "Get Audiences" do
            tags 'Audiences'
            #security [ Bearer: [] ]
            consumes 'application/json'
            description "Get Audiences"      
            parameter name: :per, :in => :query, :type => :integer, :description => 'results per page', :default => 10, required: false
            parameter name: :page, :in => :query, :type => :integer, :description => 'page', :default => 1, required: false

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
                                example: "//gallery/v1/audiences?page[number]=1&page[size]=10"
                            },
                            first: {
                                type: :string,
                                format: :url,
                                example: "//gallery/v1/audiences?page[number]=1&page[size]=10"
                            },
                            prev: {
                                type: :string,
                                format: :url,
                                example: nil
                            },
                            next: {
                                type: :string,
                                format: :url,
                                example: "//gallery/v1/audiences?page[number]=2&page[size]=10"
                            },
                            last: {
                                type: :string,
                                format: :url,
                                example: "//gallery/v1/audiences?page[number]=10&page[size]=10"
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

    path '/gallery/v1/audiences/{id}' do
        get "Get a Audience" do
            tags 'Audiences'
            #security [ Bearer: [] ]
            consumes 'application/json'
            description "Get a Audience"      
            parameter name: :id, :in => :path, :type => :string, :description => 'audience id', required: true
  
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
                    required: ["data"] 
                run_test!
            end
  
  
            response '404', 'Audience Not Found' do
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