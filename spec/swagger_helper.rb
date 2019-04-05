require 'rails_helper'

RSpec.configure do |config|
    # Specify a root folder where Swagger JSON files are generated
    # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
    # to ensure that it's configured to serve Swagger from the same folder
    config.swagger_root = Rails.root.to_s + '/swagger'

    # Define one or more Swagger documents and provide global metadata for each one
    # When you run the 'rswag:specs:to_swagger' rake task, the complete Swagger will
    # be generated at the provided relative path under swagger_root
    # By default, the operations defined in spec files are added to the first
    # document below. You can override this behavior by adding a swagger_doc tag to the
    # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
    config.swagger_docs = {
        'v1/swagger.json' => {
            swagger: '2.0',
            info: {
                title: 'RBAC-API',
                version: 'v1'
            },
            paths: {},
            # securityDefinitions: {
            #     Bearer: {
            #     type: :apiKey,
            #     name: 'Authorization',
            #     in: :header,
            #     }
            # }
        },
        definitions:{
            meta_pagination_object: {
                type: :object,
                properties:{
                  current_page: {
                    type: :integer,
                    example: 1
                  },
                  next_page: {
                    type: :integer,
                    example: 2
                  },
                  prev_page: {
                    type: :integer,
                    example: nil
                  },
                  total_pages: {
                    type: :integer,
                    example: 10
                  },
                  total_count: {
                    type: :integer,
                    example: 100
                  }
                },
                required: [ 'current_page', 'total_pages', 'total_count']
            },  
            activities_object: {
                type: :object,
                properties: {
                  id: {
                    type: :string,
                    example: '715bd60f-4f85-453f-84dd-ac2fe74e16ae'
                  },
                  type: {
                    type: :string,
                    example: 'gallery-activities'
                  },
                  attributes: {
                    '$ref' => '#/definitions/activity_object' 
                  }
                },
                required: [ 'id', 'type', 'attributes']
            },
            activity_object: {
                type: :object,
                properties: {
                    title: { 
                        type: :string,
                        example: 'Atividade'
                    },
                    caption: {
                        type: :string, 
                        example: 'Atividade em sala' 
                    },
                    description: {
                        type: :string, 
                        example: 'Primeira atividade' 
                    },
                    motivation:{
                        type: :string,
                        example:"Ensinamentos basicos"
                    },
                    powerful_ideas:{
                        type: :string,
                        example:"Ideias"
                    },
                    products:{
                        type: :string,
                        example:"Produtos"
                    },
                    requirements:{
                        type: :string,
                        example:"Ingles"
                    },
                    published:{
                        type: :boolean,
                        example:true
                    },
                    version_history:{
                        type: :string,
                        example:"1.0"
                    },
                    copyright:{
                        type: :string,
                        example:"rbac"
                    },
                    license_type:{
                        type: :string,
                        example:"License"
                    },
                    scopes: {
                        type: :array,
                        items:{
                            
                        }
                    },
                    audiences: {
                        type: :array,
                        items:{
                            
                        }
                    }
                },
                required: ['title']
            }
        }
    }
end