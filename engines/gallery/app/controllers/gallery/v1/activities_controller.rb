require_dependency "gallery/application_controller"

module Gallery
  module V1
    class ActivitiesController < ApplicationController
      before_action :set_activity, only: [:show, :update, :destroy, :like, :favorite]
      #skip_before_action :authenticate, :only => [:index, :page]


      # GET /gallery/v1/activities
      def index
        if params[:global]
          @activities = Gallery::Activity.search_global(params[:global])
        else
          @activities = Gallery::Activity.all
        end
        
        @activities = @activities.page(params[:page] || 1)
        @activities = @activities.per(params[:per] || 10)
        @activities = Gallery::FunctionsActivity.verify_activities_reaction(@activities, @current_user.usereable)

        render json: @activities, meta: pagination_dict(@activities)
      end


      # POST gallery/v1/activities
      def create
        @activity = Gallery::Activity.create(activity_params)
        if @activity.save
          Gallery::FunctionsActivity.crud_general_materials(@activity, params)
          Gallery::FunctionsActivity.crud_inspirations(@activity, params)
          render json: @activity
        else
          render json: @activity.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT gallery/v1/activities/:id
      def update
        if @activity.update(activity_params)
          Gallery::FunctionsActivity.crud_general_materials(@activity, params, true)
          Gallery::FunctionsActivity.crud_inspirations(@activity, params, true)
          render json: @activity
        else
          render json: @activity.errors, status: :unprocessable_entity
        end
      end

      # GET /gallery/v1/activities/:id
      def show
        @activity = Gallery::FunctionsActivity.reactions_activity(@activity, @current_user)
        render json: @activity
      end
      
      # DELETE /gallery/v1/activities/:id
      def destroy
        @activity.destroy
      end

      # GET /gallery/v1/activities/:id/like
      def like
        if @activity.likes.find_by(person: @current_user.usereable)
          like = @activity.likes.find_by(person: @current_user.usereable)
          like.destroy
        else
          @activity.likes.create(person: @current_user.usereable)
        end
        @activity = Gallery::FunctionsActivity.reactions_activity(@activity, @current_user)
        render json: @activity
      end

      # GET /gallery/v1/activities/:id/favorite
      def favorite
        if @activity.favorites.find_by(person: @current_user.usereable)
          favorite = @activity.favorites.find_by(person: @current_user.usereable)
          favorite.destroy
        else
          @activity.favorites.create(person: @current_user.usereable)
        end
        @activity = Gallery::FunctionsActivity.reactions_activity(@activity, @current_user)
        render json: @activity
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
          params.require(:activity).permit(:title, :caption, :description, :image ,:motivation, :powerful_ideas, :products, :requirements, :published, :version_history, :copyright, :license_type, :space_organization, :implementation_steps, :implementation_tips, :reflection_assessment, :duration, :inspiration, :references, specific_materials_attributes:[:id, :name, :quantity, :description, :_destroy],  scope_ids:[], audience_ids:[], person_ids:[], space_type_ids: [])
        end
    end
  end
end
