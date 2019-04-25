require_dependency "gallery/application_controller"

module Gallery
  module V1
    class ActivitiesController < ApplicationController
      before_action :set_activity, only: [:show, :update, :destroy]
      #skip_before_action :authenticate, :only => [:index, :page]


      # GET /gallery/v1/activities
      def index
        @activities = Gallery::Activity.all

        @activities = @activities.page(params[:page] || 1)
        @activities = @activities.per(params[:per] || 10)

        render json: @activities, meta: pagination_dict(@activities)
      end


      # POST gallery/v1/activities
      def create
        @activity = Gallery::Activity.create(activity_params)
        if @activity.save
          Gallery::FunctionsActivity.crud_general_materials(@activity, params)
          render json: @activity
        else
          render json: @activity.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT gallery/v1/activities/:id
      def update
        if @activity.update(activity_params)
          Gallery::FunctionsActivity.crud_general_materials(@activity, params, true)
          render json: @activity
        else
          render json: @activity.errors, status: :unprocessable_entity
        end
      end

      # GET /gallery/v1/activities/:id
      def show
        render json: @activity
      end
      
      # DELETE /gallery/v1/activities/:id
      def destroy
        @activity.destroy
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
        def set_activity
          @activity = Activity.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def activity_params
          params.require(:activity).permit(:title, :caption, :description, :image ,:motivation, :powerful_ideas, :products, :requirements, :published, :version_history, :copyright, :license_type, :space_organization, :implementation_steps, :implementation_tips, :reflection_assessment, :duration, specific_materials_attributes:[:id, :name, :quantity, :_destroy],  scope_ids:[], audience_ids:[], person_ids:[], space_type_ids: [])
        end
    end
  end
end
