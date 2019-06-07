


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
                title: 'API V1',
                version: 'v1'
            },
            paths: {},
            securityDefinitions: {
                Bearer: {
                type: :apiKey,
                name: 'Authorization',
                in: :header,
                }
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
                        space_organization:{
                            type: :string,
                            example:"Precisa de projetor para realizar a atividade"
                        },
                        implementation_steps:{
                            type: :string,
                            example:"Primeiramente ler a apostila pagina 2"
                        },
                        implementation_tips:{
                            type: :string,
                            example:"Realizar a atividade durante o dia"
                        },
                        reflection_assessment:{
                            type: :string,
                            example:"Avaliar o comportamento do aluno"
                        },
                        duration:{
                            type: :string,
                            example:"Cerca de 30 minutos"
                        },
                        inspiration:{
                            type: :string,
                            example: "Inspirada na atividade 1"
                        },
                        references:{
                            type: :string,
                            example: "Referências bibliograficas"
                        },
                        remixed:{
                            type: :string,
                            example: "no"
                        },
                        liked:{
                            type: :boolean,
                            example: true
                        },
                        favorited:{
                            type: :boolean,
                            example: true
                        },
                        implemented:{
                            type: :boolean,
                            example: true
                        },
                        scopes:{
                            type: :array,
                            items: {
                                '$ref' => '#/definitions/scopes_object' 
                            }   
                        },
                        audiences:{
                            type: :array,
                            items: {
                                '$ref' => '#/definitions/audiences_object' 
                            }   
                        },
                        inspirations:{
                            type: :array,
                            items: {
                                '$ref' => '#/definitions/inspiration_object' 
                            }   
                        },
                        authors:{
                            type: :array,
                            items: {
                                '$ref' => '#/definitions/person_object' 
                            }   
                        },
                        space_types:{
                            type: :array,
                            items: {
                                '$ref' => '#/definitions/space_type_object' 
                            }   
                        },
                        specific_materials:{
                            type: :string,
                            example: "Cola e tesoura sem ponta"
                        },
                        general_materials:{
                            type: :array,
                            items: {
                                '$ref' => '#/definitions/general_materials_object' 
                            }   
                        },
                        images:{
                            '$ref' => '#/definitions/image_object' 
                               
                        },
                        comments:{
                            '$ref' => '#/definitions/comment_object' 
                        },
                        likes:{
                            '$ref' => '#/definitions/like_object' 
                        },
                        implementations:{
                            '$ref' => '#/definitions/implementation_object' 
                        }
                    },
                    required: ['title']
                },
                scopes_object: {
                    type: :object,
                    properties: {
                    id: {
                            type: :string,
                            example: '1758b1cc-ae2f-41c1-9d40-5c6bc7bdc807'
                        },
                        type: {
                            type: :string,
                            example: 'gallery-scopes'
                        },
                        attributes: {
                            '$ref' => '#/definitions/scope_object' 
                        }
                    },
                    required: [ 'id', 'type', 'attributes']
                },
                scope_object: {
                    type: :object,
                    properties: {
                        title: { 
                            type: :string,
                            example: 'Scope 1'
                        },
                        description: {
                            type: :string, 
                            example: 'Scope 1' 
                        },
                    },
                    required: [ 'title']
                },
                audiences_object: {
                    type: :object,
                    properties: {
                        id: {
                                type: :string,
                                example: '93f8345c-3e87-4485-9dfb-2a1102252020'
                        },
                        type: {
                            type: :string,
                            example: 'gallery-audiences'
                        },
                        attributes: {
                            '$ref' => '#/definitions/audience_object' 
                        }
                    },
                    required: [ 'id', 'type', 'attributes']
                },
                audience_object: {
                    type: :object,
                    properties: {
                        name: { 
                            type: :string,
                            example: 'Crianças'
                        },
                        description: {
                            type: :string, 
                            example: 'Crianças' 
                        },
                    },
                    required: [ 'title']
                },
                people_object:{
                    type: :object,
                    properties: {
                        id: {
                            type: :string,
                            example: 'f963962d-405e-4be8-93f4-ff90a85ad347'
                        },
                        type: {
                            type: :string,
                            example: 'user-people'
                        },
                        attributes: {
                            '$ref' => '#/definitions/person_object' 
                        }
                    },
                    required: [ 'id', 'type', 'attributes']
                },
                person_object:{
                    type: :object,
                    properties: {
                        name: { 
                            type: :string,
                            example: 'Pedro'
                        },
                        email: {
                            type: :string, 
                            example: 'pedro123@gmail.com' 
                        },
                        birthday: {
                            type: :string, 
                            example: '1980-10-10' 
                        }
                    },
                    required: ['name', 'email']
                },
                error_object: {
                    type: :object,
                    properties:{
                        error: {
                        type: :object,
                        properties: {
                            lang: {
                                type: :string,
                                example: "en",
                                description: "Error Language"
                            },
                            message: {
                                type: :string,
                                example: "Friendly Message",
                                description: "Message to Show the User."
                            },
                            internal_message: {
                                type: :string,
                                example: "Bad things are happening.",
                                description: "Internal Message for Developer Control"
                            },
                            status: {
                                type: :string,
                                example: "000",
                                description: "HTTP Status Code"
                            }

                        },
                        required: ['lang', 'message', 'internal_message', 'status']
                        }
                    }
                },
                space_types_object: {
                    type: :object,
                    properties: {
                        id: {
                                type: :string,
                                example: 'df1f4ff2-c167-44b9-9b3d-50d51e909e2d'
                        },
                        type: {
                            type: :string,
                            example: 'gallery-space-types'
                        },
                        attributes: {
                            '$ref' => '#/definitions/space_type_object' 
                        }
                    },
                    required: [ 'id', 'type', 'attributes']
                },
                space_type_object: {
                    type: :object,
                    properties: {
                        title: { 
                            type: :string,
                            example: 'Sala de aula'
                        },
                        description: {
                            type: :string, 
                            example: 'Sala de aula com projetor' 
                        },
                    },
                    required: [ 'title']
                },
                specific_materials_objects:{
                    type: :object,
                    properties: {
                        id: {
                            type: :string,
                            example: '063ef0fd-4c82-475f-b50e-dd10326423b3'
                        },
                        type: {
                            type: :string,
                            example: 'gallery-specific-materials'
                        },
                        attributes: {
                            '$ref' => '#/definitions/specific_materials_object' 
                        }
                    },
                    required: [ 'id', 'type', 'attributes']
                },
                specific_materials_object:{
                    type: :object,
                    properties: {
                        name: { 
                            type: :string,
                            example: 'Tesoura sem ponta'
                        },
                        quantity: {
                            type: :integer, 
                            example: 1
                        },
                        description: {
                            type: :string, 
                            example: "Tesoura para ser usada na atividade"
                        }
                    },
                    required: [ 'name', 'quantity']
                },
                general_materials_objects:{
                    type: :object,
                    properties: {
                        id: {
                            type: :string,
                            example: '6bea14a4-0e33-4d05-a015-df79ca9a3559'
                        },
                        type: {
                            type: :string,
                            example: 'gallery-general-materials'
                        },
                        attributes: {
                            '$ref' => '#/definitions/general_materials_object' 
                        }
                    },
                    required: [ 'id', 'type', 'attributes']
                },
                general_materials_object:{
                    type: :object,
                    properties: {
                        name: { 
                            type: :string,
                            example: 'Cartolina'
                        },
                        description: {
                            type: :string, 
                            example: "Cartolina para ser usada em atividades"
                        },
                        activity_general_materials:{
                            '$ref' => '#/definitions/activity_general_materials_object' 
                        }
                    },
                    required: [ 'name', 'description']
                },
                activity_general_materials_object:{
                    type: :object,
                    properties: {
                        id: { 
                            type: :string,
                            example: '73590bc0-95f5-41ea-8337-f3e0e24709f'
                        },
                        quantity: {
                            type: :integer, 
                            example: 10
                        }
                    }
                },
                image_object:{
                    type: :object,
                    properties: {
                        original: { 
                            type: :string,
                            example: "https://s3-sa-east-1.amazonaws.com/api-rbac/noimage.jpg"
                        },
                        medium: {
                            type: :string, 
                            example: "https://s3-sa-east-1.amazonaws.com/api-rbac/noimage.jpg"
                        },
                        square: {
                            type: :string, 
                            example: "https://s3-sa-east-1.amazonaws.com/api-rbac/noimage.jpg"
                        },
                        thumbnail: {
                            type: :string, 
                            example: "https://s3-sa-east-1.amazonaws.com/api-rbac/noimage.jpg"
                        }
                    }
                },
                inspiration_object:{
                    properties: {
                        activity_two_id: {
                            type: :string, 
                            example: "819d249c-e536-43df-b688-1b9ca72eec72"
                        },
                        title:{
                            type: :string, 
                            example: "Atividade 1"
                        }
                    }
                },
                like_objects:{
                    type: :object,
                    properties: {
                        id: {
                            type: :string,
                            example: '6bea14a4-0e33-4d05-a015-df79ca9a3559'
                        },
                        type: {
                            type: :string,
                            example: 'experience-likes'
                        },
                        attributes: {
                            '$ref' => '#/definitions/like_object' 
                        }
                    },
                    required: [ 'id', 'type', 'attributes']
                },
                like_object:{
                    type: :object,
                    properties: {
                      person:{
                        '$ref' => '#/definitions/person_object' 
                      } 
                    }
                },
                implementation_objects:{
                    type: :object,
                    properties: {
                        id: {
                            type: :string,
                            example: '6bea14a4-0e33-4d05-a015-df79ca9a3559'
                        },
                        type: {
                            type: :string,
                            example: 'experience-implementation'
                        },
                        attributes: {
                            '$ref' => '#/definitions/implementation_object' 
                        }
                    },
                    required: [ 'id', 'type', 'attributes']
                },
                implementation_object:{
                    type: :object,
                    properties: {
                      person:{
                        '$ref' => '#/definitions/person_object' 
                      },
                      description: {
                        type: :string,
                        example: "Implementação em classe"
                      },
                      date_implementation: {
                        type: :string,
                        example: "2019-05-05"
                      }, 
                      place_implementation: {
                        type: :string,
                        example: "Sala de aula"
                      },
                      number_participants: {
                        type: :integer,
                        example: 10
                      }  
                    }
                },
                comment_objects:{
                    type: :object,
                    properties: {
                        id: {
                            type: :string,
                            example: '6bea14a4-0e33-4d05-a015-df79ca9a3559'
                        },
                        type: {
                            type: :string,
                            example: 'experience-comments'
                        },
                        attributes: {
                            '$ref' => '#/definitions/comment_object' 
                        }
                    },
                    required: [ 'id', 'type', 'attributes']
                },
                comment_object:{
                    type: :object,
                    properties: {
                      person:{
                        '$ref' => '#/definitions/person_object' 
                      },
                      text:{
                        type: :string,
                        example:"Comment"
                      },
                      created_at:{
                        type: :string,
                        example:"2019-01-01"
                      }
                    }
                },
            }
        }
    }
end
