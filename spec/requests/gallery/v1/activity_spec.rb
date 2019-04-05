require 'rails_helper'
require 'swagger_helper'


RSpec.describe 'Activities API', type: :request do
    path '/gallery/v1/activities/' do
        get "Get Activities" do
            tags 'Gallery'
            security [ Bearer: [] ]
            consumes 'application/json'
            description "Get Activities"      
            parameter name: :per, :in => :query, :type => :integer, :description => 'results per page', :default => 10, required: false
            parameter name: :page, :in => :query, :type => :integer, :description => 'page', :default => 1, required: false

            response '200', 'Payment Methods found' do
                schema type: :object,
                    properties: {
                        data: {
                            type: :array,
                            items: {
                                '$ref': '#/definitions/activities_object'
                            } 
                        },
                        links: {
                            type: :object,
                            properties: {
                              self: {
                                type: :string,
                                format: :url,
                                example: "//gallery/v1/activities?page[number]=1&page[size]=10"
                              },
                              first: {
                                type: :string,
                                format: :url,
                                example: "//gallery/v1/activities?page[number]=1&page[size]=10"
                              },
                              prev: {
                                type: :string,
                                format: :url,
                                example: nil
                              },
                              next: {
                                type: :string,
                                format: :url,
                                example: "//gallery/v1/activities?page[number]=2&page[size]=10"
                              },
                              last: {
                                type: :string,
                                format: :url,
                                example: "//gallery/v1/activities?page[number]=10&page[size]=10"
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
end