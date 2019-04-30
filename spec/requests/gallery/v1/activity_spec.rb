require 'rails_helper'
require 'swagger_helper'


RSpec.describe 'Activities API', type: :request do
  path '/gallery/v1/activities/' do
      get "Get Activities" do
            tags 'Activities'
            security [ Bearer: [] ]
            consumes 'application/json'
            description "Get Activities"      
            parameter name: :per, :in => :query, :type => :integer, :description => 'results per page', :default => 10, required: false
            parameter name: :page, :in => :query, :type => :integer, :description => 'page', :default => 1, required: false
            parameter name: :global, :in => :query, :type => :string, :description => 'Search global fields', required: false  

            response '200', 'Activities found' do
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

    path '/gallery/v1/activities/{id}' do
      get "Get a Activity" do
          tags 'Activities'
          security [ Bearer: [] ]
          consumes 'application/json'
          description "Get a Activity"      
          parameter name: :id, :in => :path, :type => :string, :description => 'activity id', required: true

          response '200', 'Activity found' do
              schema type: :object,
                  properties: {
                      data: {
                          type: :array,
                          items: {
                              '$ref': '#/definitions/activities_object'
                          } 
                      }
                  },
                  required: ["data"] 
              run_test!
          end

          response '401', 'Unauthorized' do
            schema '$ref': '#/definitions/error_object'
            run_test!
          end

          response '404', 'Activity Not Found' do
            schema '$ref': '#/definitions/error_object'
            run_test!
          end
          
          response '500', 'Internal Server Error' do
            schema '$ref': '#/definitions/error_object'
            run_test!
          end
          
      end
    end

    path '/gallery/v1/activities' do
      post "Create a Activity" do
          tags 'Activities'
          security [ Bearer: [] ]
          consumes 'application/json'
          description "Create a Activity"      
          parameter name: :body, in: :body, required: true, schema: {
              type: :object,
              properties: {
                  activity: {
                      type: :object,
                      properties: {
                          title: { type: :string, example: "Atividade"},
                          caption: { type: :string, example: "Atividade em sala"},
                          description: { type: :string, example: "primeira atividade em sala de aula"},
                          motivation: { type: :string, example: "Ensinamentos basicos"},
                          powerful_ideas: { type: :string, example: "Ideias"},
                          products: {type: :string, example: "Produtos"},
                          requirements: {type: :string, example: "Inglês"},
                          published: {type: :boolean, example:true},
                          version_history: {type: :string, example:"1.0"},
                          copyright: {type: :string, example:"rbac"},
                          license_type: {type: :string, example:"License"},
                          space_organization: {type: :string, example:"Precisa de projetor para realizar a atividade"},
                          implementation_steps: {type: :string, example:"Primeiramente ler a apostila pagina 2"},
                          implementation_tips: {type: :string, example:"Realizar a atividade durante o dia"},
                          reflection_assessment: {type: :string, example:"Avaliar o comportamento do aluno"},
                          duration: {type: :string, example:"cerca de 30 minutos"},
                          scope_ids: {type: :array, example:["c6a92130-6d30-42f6-93c0-245acf360152"]},
                          audience_ids: {type: :array, example:["3b11f1db-e8c2-4379-beb7-0ba7f993e23a", "93f8345c-3e87-4485-9dfb-2a1102252020"]},
                          person_ids: {type: :array, example:["3b11f1db-e8c2-4379-beb7-0ba7f993e23a"]},
                          space_type_ids: {type: :array, example:["df1f4ff2-c167-44b9-9b3d-50d51e909e2d"]}, 
                          specific_materials_attributes:{type: :array, example:[{"name": "Tesoura sem ponta", "quantity": 1}]},
                          general_materials:{type: :array, example:[{"id": "9c65a353-497a-42ed-9631-38f68c6862b0", "quantity": 11}]}
                      },
                      required: ["title","caption","description","motivation","powerful_ideas","products","requirements","published","version_history","copyright","license_type","space_organization", "duration", "implementation_steps" "scope_ids","audience_ids","person_ids", "space_type_ids", "general_materials"] 
                  }
              }
          }   
          
          response '201', 'Activity create' do
              schema type: :object,
                  properties: {
                      data: {
                          type: :array,
                          items: {
                              '$ref': '#/definitions/activities_object'
                          } 
                      }
                  },
                  required: ["data"] 
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

    path '/gallery/v1/activities/{id}' do
      put "Update a Activity" do
          tags 'Activities'
          security [ Bearer: [] ]
          consumes 'application/json'
          description "Update a Activity"
          parameter name: :id, :in => :path, :type => :string, :description => 'activity id', required: true    
          parameter name: :body, in: :body, required: true, schema: {
              type: :object,
              properties: {
                  activity: {
                      type: :object,
                      properties: {
                          title: { type: :string, example: "Atividade"},
                          caption: { type: :string, example: "Atividade em sala"},
                          description: { type: :string, example: "primeira atividade em sala de aula"},
                          motivation: { type: :string, example: "Ensinamentos basicos"},
                          powerful_ideas: { type: :string, example: "Ideias"},
                          products: {type: :string, example: "Produtos"},
                          requirements: {type: :string, example: "Inglês"},
                          published: {type: :boolean, example:true},
                          version_history: {type: :string, example:"1.0"},
                          copyright: {type: :string, example:"rbac"},
                          license_type: {type: :string, example:"License"},
                          space_organization: {type: :string, example:"Precisa de projetor para realizar a atividade"},
                          implementation_steps: {type: :string, example:"Primeiramente ler a apostila pagina 2"},
                          implementation_tips: {type: :string, example:"Realizar a atividade durante o dia"},
                          reflection_assessment: {type: :string, example:"Avaliar o comportamento do aluno"},
                          duration: {type: :string, example:"cerca de 30 minutos"},
                          scope_ids: {type: :array, example:["c6a92130-6d30-42f6-93c0-245acf360152"]},
                          audience_ids: {type: :array, example:["3b11f1db-e8c2-4379-beb7-0ba7f993e23a", "93f8345c-3e87-4485-9dfb-2a1102252020"]},
                          person_ids: {type: :array, example:["3b11f1db-e8c2-4379-beb7-0ba7f993e23a"]},
                          space_type_ids: {type: :array, example:["df1f4ff2-c167-44b9-9b3d-50d51e909e2d"]},
                          specific_materials_attributes:{type: :array, example:[{"name": "Tesoura sem ponta", "quantity": 1}, {"id": "063ef0fd-4c82-475f-b50e-dd10326423b3", "name": "Tesoura sem ponta", "quantity": 1, "_destroy": true}], description: "To delete a material pass the id in the object, and the attribute _destroy: true"},
                          general_materials:{type: :array, example:[{"id": "9c65a353-497a-42ed-9631-38f68c6862b0", "quantity": 11}]}
                      },
                      required: ["title","caption","description","motivation","powerful_ideas","products","requirements","published","version_history","copyright","license_type","space_organization", "duration", "implementation_steps" "scope_ids","audience_ids","person_ids", "space_type_ids", "general_materials"] 
                  }
              }
          }   
          
          response '200', 'Activity update' do
              schema type: :object,
                  properties: {
                      data: {
                          type: :array,
                          items: {
                              '$ref': '#/definitions/activities_object'
                          } 
                      }
                  },
                  required: ["data"] 
              run_test!
          end

          response '401', 'Unauthorized' do
            schema '$ref': '#/definitions/error_object'
            run_test!
          end
          
          response '404', 'Activity Not Found' do
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

    path '/gallery/v1/activities/{id}' do
      delete "Delete a Activity" do
          tags 'Activities'
          security [ Bearer: [] ]
          consumes 'application/json'
          description "Delete a Activity"
          parameter name: :id, :in => :path, :type => :string, :description => 'activity id', required: true      

          
          response '204', 'Activity delete' do
            schema '$ref': '#/definitions/error_object'
            run_test!
          end

          response '401', 'Unauthorized' do
            schema '$ref': '#/definitions/error_object'
            run_test!
          end
          
          response '404', 'Activity Not Found' do
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