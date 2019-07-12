# frozen_string_literal: true

require_dependency 'gallery/application_controller'

module Gallery
  module V1
    class SpaceTypesController < ApplicationController
      before_action :set_space_type, only: %i[show update destroy]
      skip_before_action :authenticate, only: [:index]

      # GET /gallery/v1/space_types
      def index
        @space_types = Gallery::SpaceType.all

        @space_types = @space_types.page(params[:page] || 1)
        @space_types = @space_types.per(params[:per] || 10)

        render json: @space_types, meta: pagination_dict(@space_types)
      end

      # POST /gallery/v1/space_types
      def create
        @space_type = Gallery::SpaceType.create(space_type_params)
        if @space_type.save
          render json: @space_type
        else
          render json: @space_type.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT gallery/v1/space_types/:id
      def update
        if @space_type.update(space_type_params)
          render json: @space_type
        else
          render json: @space_type.errors, status: :unprocessable_entity
        end
      end

      # GET /gallery/v1/space_types/:id
      def show
        render json: @space_type
      end

      # DELETE /gallery/v1/space_types/:id
      def destroy
        @space_type.destroy
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
      def set_space_type
        @space_type = SpaceType.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def space_type_params
        params.require(:space_type).permit(:title, :description)
      end
    end
  end
end
