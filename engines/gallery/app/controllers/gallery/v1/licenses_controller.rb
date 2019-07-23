# frozen_string_literal: true

require_dependency "gallery/application_controller"

module Gallery
  module V1
    class LicensesController < ApplicationController
      before_action :set_license, only: %i[show update destroy]
      skip_before_action :authenticate, only: [:index]

      # GET /gallery/v1/licenses
      def index
        @licenses = Gallery::License.all

        @licenses = @licenses.page(params[:page] || 1)
        @licenses = @licenses.per(params[:per] || 10)

        render json: @licenses, meta: pagination_dict(@licenses)
      end

      # POST /gallery/v1/license
      def create
        @license = Gallery::License.create(license_params)
        if @license.save
          render json: @license, status: :created
        else
          render json: @license.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT gallery/v1/licenses/:id
      def update
        if @license.update(license_params)
          render json: @license
        else
          render json: @license.errors, status: :unprocessable_entity
        end
      end

      # GET /gallery/v1/licenses/:id
      def show
        render json: @license
      end

      # DELETE /gallery/v1/licenses/:id
      def destroy
        @license.destroy
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
      def set_license
        @license = License.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def license_params
        params.require(:license).permit(:title, :acronym, :version, :description, :external_link)
      end
    end
  end
end
