require_dependency "user/application_controller"

module User
  module V1
    class PeopleController < ApplicationController
      before_action :set_person, only: [:show]
      #skip_before_action :authenticate, :only => [:index, :page]


      # GET /user/v1/people
      def index
        @people = User::Person.all

        @people = @people.page(params[:page] || 1)
        @people = @people.per(params[:per] || 10)

        render json: @people, meta: pagination_dict(@people)
      end

      # GET /user/v1/people/:id
      def show
        render json: @person
      end
    

      def pagination_dict(collection)
        {
          current_page: collection.current_page,
          next_page: collection.next_page,
          prev_page: collection.prev_page, # use collection.previous_page when using will_paginate
          total_pages: collection.total_pages,
          total_count: collection.total_count
        }
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_person
          @person = Person.find(params[:id])
        end
    end
  end
end
