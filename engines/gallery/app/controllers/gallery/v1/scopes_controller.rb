require_dependency "gallery/application_controller"

module Gallery
  module V1
    class ScopesController < ApplicationController
      before_action :set_scope, only: [:show]
      #skip_before_action :authenticate, :only => [:index, :page]


      # GET /gallery/v1/scopes
      def index
        @scopes = Gallery::Scope.all

        @scopes = @scopes.page(params[:page] || 1)
        @scopes = @scopes.per(params[:per] || 10)

        render json: @scopes, meta: pagination_dict(@scopes)
      end


      # GET /gallery/v1/scopes/:id
      def show
        render json: @scope
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
        def set_scope
          @scope = Scope.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def scope_params
          params.require(:scope).permit(:name, :description)
        end
    end
  end
end
