# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Activities API', type: :request do
  path '/gallery/v1/activities/' do
    get 'Get Activities' do
      tags 'Activities'
      consumes 'application/json'
      description 'Get Activities'
      parameter name: :per, in: :query, type: :integer, description: 'results per page', default: 10, required: false
      parameter name: :page, in: :query, type: :integer, description: 'page', default: 1, required: false
      parameter name: :global, in: :query, type: :string, description: 'Search global fields', required: false
      parameter name: :scope_ids, in: :query, type: :string, description: 'Search by scope, scope_ids=id1,id2', required: false
      parameter name: :author_ids, in: :query, type: :string, description: 'Search by author, author_ids=id1,id2', required: false
      parameter name: :license_ids, in: :query, type: :string, description: 'Search by license, license_ids=id1,id2', required: false
      parameter name: :audience_ids, in: :query, type: :string, description: 'Search by audience, audience_ids=id1,id2', required: false
      parameter name: :space_type_ids, in: :query, type: :string, description: 'Search by space type, space_type_ids=id1,id2', required: false
      parameter name: :activity_type, in: :query, type: :array, description: 'Search by activity type', required: false, items: {
        type: :string, enum: ['internal', 'external'], default: 'internal'
      }
      parameter name: :order, in: :query, type: :array, description: 'Sort query by order param', required: false, items: {
        type: :string, enum: [
          'title ASC',
          'title DESC',
          'updated_at DESC',
          'total_favorites DESC',
          'total_implementations DESC',
          'total_remixes DESC'
        ],
        default: 'title ASC'
      }

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
                       example: '//gallery/v1/activities?page[number]=1&page[size]=10'
                     },
                     first: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/activities?page[number]=1&page[size]=10'
                     },
                     prev: {
                       type: :string,
                       format: :url,
                       example: nil
                     },
                     next: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/activities?page[number]=2&page[size]=10'
                     },
                     last: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/activities?page[number]=10&page[size]=10'
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

  path '/gallery/v1/activities/{id}' do
    get 'Get a Activity' do
      tags 'Activities'
      security [Bearer: []]
      consumes 'application/json'
      description 'Get a Activity'
      parameter name: :id, in: :path, type: :string, description: 'activity id', required: true

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
               required: ['data']
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

  path '/gallery/v1/activities/{id}/pdf' do
    get 'Get a Activity PDF' do
      tags 'Activities'
      security [Bearer: []]
      consumes 'application/json'
      description 'Get a Activity File PDF for download'
      parameter name: :id, in: :path, type: :string, description: 'activity id', required: true

      response '200', 'Activity File PDF create' do
        schema type: :object,
               properties: {
                 url: {
                   type: :string,
                   example: 'www.domain.com/172735e6-46e1-4946-b082-d486069c4f91.pdf'
                 }
               }
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
    post 'Create a Activity' do
      tags 'Activities'
      security [Bearer: []]
      consumes 'application/json'
      description 'Create a Activity'
      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          activity: {
            type: :object,
            properties: {
              title: { type: :string, example: 'Atividade' },
              caption: { type: :string, example: 'Atividade em sala' },
              description: { type: :string, example: 'primeira atividade em sala de aula' },
              motivation: { type: :string, example: 'Ensinamentos basicos' },
              powerful_ideas: { type: :string, example: 'Ideias' },
              products: { type: :string, example: 'Produtos' },
              requirements: { type: :string, example: 'Inglês' },
              published: { type: :boolean, example: true },
              version_history: { type: :string, example: '1.0' },
              copyright: { type: :string, example: 'rbac' },
              space_organization: { type: :string, example: 'Precisa de projetor para realizar a atividade' },
              implementation_steps: { type: :string, example: 'Primeiramente ler a apostila pagina 2' },
              implementation_tips: { type: :string, example: 'Realizar a atividade durante o dia' },
              reflection_assessment: { type: :string, example: 'Avaliar o comportamento do aluno' },
              duration: { type: :string, example: 'cerca de 30 minutos' },
              references: { type: :string, example: 'Referências bibliograficas' },
              is_abac_author: { type: :boolean, example: false },
              external_link: { type: :string, example: 'https://scholar.google.com.br/' },
              external_authors: { type: :array, example: ['Pedro', 'João da silva', 'Osvaldo'] },
              activity_type: { type: :string, description: 'Activity type', enum: %w[internal external], default: 'internal' },
              license_id: { type: :string, example: 'c6a92130-6d30-42f6-93c0-245acf360152' },
              scope_ids: { type: :array, example: ['c6a92130-6d30-42f6-93c0-245acf360152'] },
              audience_ids: { type: :array, example: %w[3b11f1db-e8c2-4379-beb7-0ba7f993e23a 93f8345c-3e87-4485-9dfb-2a1102252020] },
              person_ids: { type: :array, example: ['3b11f1db-e8c2-4379-beb7-0ba7f993e23a'] },
              space_type_ids: { type: :array, example: ['df1f4ff2-c167-44b9-9b3d-50d51e909e2d'] },
              specific_materials: { type: :string, example: 'Cola e tesoura sem ponta' },
              general_materials: { type: :array, example: [{ "id": '9c65a353-497a-42ed-9631-38f68c6862b0', "quantity": 11 }] },
              image: { type: :string, example: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP0Y/hfDwADvwHOEMGxZAAAAABJRU5ErkJggg==' },
              inspirations_ids: { type: :array, example: ['819d249c-e536-43df-b688-1b9ca72eec72'] }
            },
            required: ['title', 'caption', 'description', 'motivation', 'powerful_ideas', 'products', 'requirements', 'published', 'version_history', 'copyright', 'space_organization', 'duration', 'implementation_steps' 'scope_ids', 'audience_ids', 'person_ids', 'space_type_ids', 'general_materials']
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

  path '/gallery/v1/activities/{id}' do
    put 'Update a Activity' do
      tags 'Activities'
      security [Bearer: []]
      consumes 'application/json'
      description 'Update a Activity'
      parameter name: :id, in: :path, type: :string, description: 'activity id', required: true
      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          activity: {
            type: :object,
            properties: {
              title: { type: :string, example: 'Atividade' },
              caption: { type: :string, example: 'Atividade em sala' },
              description: { type: :string, example: 'primeira atividade em sala de aula' },
              motivation: { type: :string, example: 'Ensinamentos basicos' },
              powerful_ideas: { type: :string, example: 'Ideias' },
              products: { type: :string, example: 'Produtos' },
              requirements: { type: :string, example: 'Inglês' },
              published: { type: :boolean, example: true },
              version_history: { type: :string, example: '1.0' },
              copyright: { type: :string, example: 'rbac' },
              space_organization: { type: :string, example: 'Precisa de projetor para realizar a atividade' },
              implementation_steps: { type: :string, example: 'Primeiramente ler a apostila pagina 2' },
              implementation_tips: { type: :string, example: 'Realizar a atividade durante o dia' },
              reflection_assessment: { type: :string, example: 'Avaliar o comportamento do aluno' },
              duration: { type: :string, example: 'cerca de 30 minutos' },
              references: { type: :string, example: 'Referências bibliograficas' },
              is_abac_author: { type: :boolean, example: false },
              external_link: { type: :string, example: 'https://scholar.google.com.br/' },
              external_authors: { type: :array, example: ['Pedro', 'João da silva', 'Osvaldo'] },
              activity_type: { type: :string, description: 'Activity type', enum: %w[internal external], default: 'internal' },
              license_id: { type: :string, example: 'c6a92130-6d30-42f6-93c0-245acf360152' },
              scope_ids: { type: :array, example: ['c6a92130-6d30-42f6-93c0-245acf360152'] },
              audience_ids: { type: :array, example: %w[3b11f1db-e8c2-4379-beb7-0ba7f993e23a 93f8345c-3e87-4485-9dfb-2a1102252020] },
              person_ids: { type: :array, example: ['3b11f1db-e8c2-4379-beb7-0ba7f993e23a'] },
              space_type_ids: { type: :array, example: ['df1f4ff2-c167-44b9-9b3d-50d51e909e2d'] },
              specific_materials: { type: :string, example: 'Cola e tesoura sem ponta' },
              general_materials: { type: :array, example: [{ "id": '9c65a353-497a-42ed-9631-38f68c6862b0', "quantity": 11 }] },
              image: { type: :string, example: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP0Y/hfDwADvwHOEMGxZAAAAABJRU5ErkJggg==' },
              inspirations_ids: { type: :array, example: ['819d249c-e536-43df-b688-1b9ca72eec72'] }
            },
            required: ['title', 'caption', 'description', 'motivation', 'powerful_ideas', 'products', 'requirements', 'published', 'version_history', 'copyright',  'space_organization', 'duration', 'implementation_steps' 'scope_ids', 'audience_ids', 'person_ids', 'space_type_ids', 'general_materials']
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
               required: ['data']
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
    delete 'Delete a Activity' do
      tags 'Activities'
      security [Bearer: []]
      consumes 'application/json'
      description 'Delete a Activity'
      parameter name: :id, in: :path, type: :string, description: 'activity id', required: true

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

  path '/gallery/v1/activities/{id}/like' do
    get 'Like a activity' do
      tags 'Activities'
      security [Bearer: []]
      consumes 'application/json'
      description 'Like or unlike, a activity'
      parameter name: :id, in: :path, type: :string, description: 'activity id', required: true

      response '200', 'liked or unliked' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/activities_object'
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

  path '/gallery/v1/activities/{id}/favorite' do
    get 'Favorite a activity' do
      tags 'Activities'
      security [Bearer: []]
      consumes 'application/json'
      description 'Favorite a activity'
      parameter name: :id, in: :path, type: :string, description: 'activity id', required: true

      response '200', 'Favorited' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/activities_object'
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

  path '/gallery/v1/activities/{id}/remix' do
    post 'Remix a Activity' do
      tags 'Activities'
      security [Bearer: []]
      consumes 'application/json'
      description 'Remix a Activity'
      parameter name: :id, in: :path, type: :string, description: 'activity id', required: true
      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          activity: {
            type: :object,
            properties: {
              title: { type: :string, example: 'Atividade' },
              caption: { type: :string, example: 'Atividade em sala' },
              description: { type: :string, example: 'primeira atividade em sala de aula' },
              motivation: { type: :string, example: 'Ensinamentos basicos' },
              powerful_ideas: { type: :string, example: 'Ideias' },
              products: { type: :string, example: 'Produtos' },
              requirements: { type: :string, example: 'Inglês' },
              published: { type: :boolean, example: true },
              version_history: { type: :string, example: '1.0' },
              copyright: { type: :string, example: 'rbac' },
              space_organization: { type: :string, example: 'Precisa de projetor para realizar a atividade' },
              implementation_steps: { type: :string, example: 'Primeiramente ler a apostila pagina 2' },
              implementation_tips: { type: :string, example: 'Realizar a atividade durante o dia' },
              reflection_assessment: { type: :string, example: 'Avaliar o comportamento do aluno' },
              duration: { type: :string, example: 'cerca de 30 minutos' },
              references: { type: :string, example: 'Referências bibliograficas' },
              is_abac_author: { type: :boolean, example: false },
              external_link: { type: :string, example: 'https://scholar.google.com.br/' },
              external_authors: { type: :array, example: ['Pedro', 'João da silva', 'Osvaldo'] },
              activity_type: { type: :string, description: 'Activity type', enum: %w[internal external], default: 'internal' },
              license_id: { type: :string, example: 'c6a92130-6d30-42f6-93c0-245acf360152' },
              scope_ids: { type: :array, example: ['c6a92130-6d30-42f6-93c0-245acf360152'] },
              audience_ids: { type: :array, example: %w[3b11f1db-e8c2-4379-beb7-0ba7f993e23a 93f8345c-3e87-4485-9dfb-2a1102252020] },
              person_ids: { type: :array, example: ['3b11f1db-e8c2-4379-beb7-0ba7f993e23a'] },
              space_type_ids: { type: :array, example: ['df1f4ff2-c167-44b9-9b3d-50d51e909e2d'] },
              specific_materials: { type: :string, example: 'Cola e tesoura sem ponta' },
              general_materials: { type: :array, example: [{ "id": '9c65a353-497a-42ed-9631-38f68c6862b0', "quantity": 11 }] },
              image: { type: :string, example: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP0Y/hfDwADvwHOEMGxZAAAAABJRU5ErkJggg==' },
              inspirations_ids: { type: :array, example: ['819d249c-e536-43df-b688-1b9ca72eec72'] }
            },
            required: ['title', 'caption', 'description', 'motivation', 'powerful_ideas', 'products', 'requirements', 'published', 'version_history', 'copyright', 'space_organization', 'duration', 'implementation_steps' 'scope_ids', 'audience_ids', 'person_ids', 'space_type_ids', 'general_materials']
          }
        }
      }

      response '200', 'Activity remixed' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/activities_object'
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

  path '/gallery/v1/activities/{id}/implement' do
    post 'Implemented this activity' do
      tags 'Activities'
      security [Bearer: []]
      consumes 'application/json'
      description 'I implemented this activity'
      parameter name: :id, in: :path, type: :string, description: 'activity id', required: true
      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          date_implementation: { type: :string, example: '2019-05-01' },
          place_implementation: { type: :string, example: 'MIT' },
          number_participants: { type: :integer, example: 10 },
          description: { type: :string, example: 'Implementação em classe' },
          person_ids: { type: :array, example: ['3b11f1db-e8c2-4379-beb7-0ba7f993e23a'] }

        },
        required: ['date_implementation']
      }

      response '200', 'Activity implemented' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/activities_object'
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

  path '/gallery/v1/activities/{id}/likes' do
    get 'Get likes a activity' do
      tags 'Activities'
      security [Bearer: []]
      consumes 'application/json'
      description 'Get likes a activity'
      parameter name: :id, in: :path, type: :string, description: 'activity id', required: true
      parameter name: :per, in: :query, type: :integer, description: 'results per page', default: 10, required: false
      parameter name: :page, in: :query, type: :integer, description: 'page', default: 1, required: false

      response '200', 'Ok' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/like_objects'
                   }
                 },
                 links: {
                   type: :object,
                   properties: {
                     self: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/activities?page[number]=1&page[size]=10'
                     },
                     first: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/activities?page[number]=1&page[size]=10'
                     },
                     prev: {
                       type: :string,
                       format: :url,
                       example: nil
                     },
                     next: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/activities?page[number]=2&page[size]=10'
                     },
                     last: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/activities?page[number]=10&page[size]=10'
                     }
                   },
                   required: %w[self first last]
                 },
                 meta: {
                   '$ref': '#/definitions/meta_pagination_object'
                 }
               },
               required: ['data']
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

  path '/gallery/v1/activities/{id}/implementations' do
    get 'Get implementations a activity' do
      tags 'Activities'
      security [Bearer: []]
      consumes 'application/json'
      description 'Get implementations a activity'
      parameter name: :id, in: :path, type: :string, description: 'activity id', required: true
      parameter name: :per, in: :query, type: :integer, description: 'results per page', default: 10, required: false
      parameter name: :page, in: :query, type: :integer, description: 'page', default: 1, required: false

      response '200', 'Ok' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/implementation_objects'
                   }
                 },
                 links: {
                   type: :object,
                   properties: {
                     self: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/activities?page[number]=1&page[size]=10'
                     },
                     first: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/activities?page[number]=1&page[size]=10'
                     },
                     prev: {
                       type: :string,
                       format: :url,
                       example: nil
                     },
                     next: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/activities?page[number]=2&page[size]=10'
                     },
                     last: {
                       type: :string,
                       format: :url,
                       example: '//gallery/v1/activities?page[number]=10&page[size]=10'
                     }
                   },
                   required: %w[self first last]
                 },
                 meta: {
                   '$ref': '#/definitions/meta_pagination_object'
                 }
               },
               required: ['data']
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

  path '/gallery/v1/activities/{id}/comment' do
    post 'Comment a activity' do
      tags 'Activities'
      security [Bearer: []]
      consumes 'application/json'
      description 'Comment a activity'
      parameter name: :id, in: :path, type: :string, description: 'activity id', required: true
      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          text: { type: :string, example: 'Comments' }
        },
        required: ['text']
      }

      response '200', 'Comment ok' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref': '#/definitions/activities_object'
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
