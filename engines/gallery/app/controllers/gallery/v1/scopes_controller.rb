# frozen_string_literal: true

require_dependency 'gallery/application_controller'

module Gallery
  module V1
    class ScopesController < ApplicationController
      before_action :set_scope, only: %i[show update destroy]
      skip_before_action :authenticate, only: [:index]

      # GET /gallery/v1/scopes
      def index
        @scopes = Gallery::Scope.all

        @scopes = @scopes.page(params[:page] || 1)
        @scopes = @scopes.per(params[:per] || 10)

        render json: @scopes, meta: pagination_dict(@scopes)
      end

      # POST /gallery/v1/scope
      def create
        @scope = Gallery::Scope.create(scope_params)
        if @scope.save
          render json: @scope
        else
          render json: @scope.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT gallery/v1/scopes/:id
      def update
        if @scope.update(scope_params)
          render json: @scope
        else
          render json: @scope.errors, status: :unprocessable_entity
        end
      end

      # GET /gallery/v1/scopes/:id
      def show
        render json: @scope
      end

      # DELETE /gallery/v1/scopes/:id
      def destroy
        @scope.destroy
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
        params.require(:scope).permit(:title, :description)
      end
    end
  end
end
