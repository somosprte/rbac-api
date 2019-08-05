# frozen_string_literal: true

require_dependency 'gallery/application_controller'

module Gallery
  module V1
    class GeneralMaterialsController < ApplicationController
      before_action :set_general_material, only: %i[show update destroy]
      skip_before_action :authenticate, :only => [:index]

      # GET /gallery/v1/general_materials
      def index
        @general_materials = Gallery::GeneralMaterial.all

        @general_materials = @general_materials.page(params[:page] || 1)
        @general_materials = @general_materials.per(params[:per] || 10)

        render json: @general_materials, meta: pagination_dict(@general_materials)
      end

      # POST /gallery/v1/general_materials
      def create
        @general_material = Gallery::GeneralMaterial.create(general_material_params)
        if @general_material.save
          render json: @general_material
        else
          render json: @general_material.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT gallery/v1/general_materials/:id
      def update
        if @general_material.update(general_material_params)
          render json: @general_material
        else
          render json: @general_material.errors, status: :unprocessable_entity
        end
      end

      # GET /gallery/v1/general_materials/:id
      def show
        render json: @general_material
      end

      # DELETE /gallery/v1/space_types/:id
      def destroy
        @general_material.destroy
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
      def set_general_material
        @general_material = GeneralMaterial.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def general_material_params
        params.require(:general_material).permit(:name, :description)
      end
    end
  end
end
