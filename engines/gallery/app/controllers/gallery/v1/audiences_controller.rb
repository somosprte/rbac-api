require_dependency "gallery/application_controller"

module Gallery
  module V1
    class AudiencesController < ApplicationController
      before_action :set_audience, only: [:show]
      #skip_before_action :authenticate, :only => [:index, :page]


      # GET /gallery/v1/audiences
      def index
        @audiences = Gallery::Audience.all

        @audiences = @audiences.page(params[:page] || 1)
        @audiences = @audiences.per(params[:per] || 10)

        render json: @audiences, meta: pagination_dict(@audiences)
      end


      # GET /gallery/v1/audiences/:id
      def show
        render json: @audience
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
        def set_audience
          @audience = Audience.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def audience_params
          params.require(:audience).permit(:name, :description)
        end
    end
  end
end
