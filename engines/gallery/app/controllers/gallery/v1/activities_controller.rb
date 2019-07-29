# frozen_string_literal: true

require_dependency 'gallery/application_controller'

module Gallery
  module V1
    class ActivitiesController < ApplicationController
      before_action :set_activity, only: %i[show pdf update destroy like favorite remix implement get_likes get_implementations comment]
      skip_before_action :authenticate, only: %i[index show]

      # GET /gallery/v1/activities
      def index
        @activities = Gallery::Activity
                      .search_global(params[:global])
                      .search_by_scopes(params[:scope_ids])
                      .search_by_authors(params[:author_ids])
                      .search_by_licenses(params[:license_ids])
                      .search_by_audiences(params[:audience_ids])
                      .search_by_space_types(params[:space_type_ids])
                      .search_by_activity_type(params[:activity_type])
                      .where(published: true)
                      .order_by(params[:order])
        @activities = @activities.page(params[:page] || 1)
        @activities = @activities.per(params[:per] || 10)

        @activities = Gallery::FunctionsActivity.verify_activities_reaction(@activities, current_user, auth_present?)

        render json: @activities, meta: pagination_dict(@activities)
      end

      # POST gallery/v1/activities
      def create
        params[:activity][:inserted_by] = @current_user.usereable_id
        @activity = Gallery::Activity.create(activity_params)
        if @activity.save
          Gallery::FunctionsActivity.crud_general_materials(@activity, params)
          Gallery::FunctionsActivity.crud_inspirations(@activity, params)
          render json: @activity, status: :created
        else
          render json: @activity.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT gallery/v1/activities/:id
      def update
        authorize @activity
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
        @activity = Gallery::FunctionsActivity.reactions_activity(@activity, current_user, auth_present?)
        render json: @activity
      end

      # GET /gallery/v1/activities/:id/pdf
      def pdf
        Gallery::V1.pdf_generate(@activity)
        render json: { "url": "/#{@activity.id}.pdf" }
      end

      # DELETE /gallery/v1/activities/:id
      def destroy
        authorize @activity
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
        @activity = Gallery::FunctionsActivity.reactions_activity(@activity, @current_user, auth_present?)
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
        @activity = Gallery::FunctionsActivity.reactions_activity(@activity, @current_user, auth_present?)
        render json: @activity
      end

      # POST /gallery/v1/activities/:id/remix
      def remix
        activity_remixed = @activity.amoeba_dup
        activity_remixed.remixed = 1
        activity_remixed.image = @activity.image
        activity_remixed.inserted_by = @current_user.usereable_id     
        activity_remixed.person_ids = @activity.people.ids
        activity_remixed.scope_ids = @activity.scopes.ids
        activity_remixed.audience_ids = @activity.audiences.ids
        activity_remixed.space_type_ids = @activity.space_types.ids
        activity_remixed.save
        activity_remixed.inspirations.create(activity_two_id: @activity.id, title: @activity.title)
        if activity_remixed.update(activity_params)
          @activity.remixes.create(person: @current_user.usereable, activity_id: activity_remixed.id)
          Gallery::FunctionsActivity.crud_general_materials(activity_remixed, params, true)
          Gallery::FunctionsActivity.crud_inspirations(activity_remixed, params, true)
          render json: activity_remixed
        else
          activity_remixed.destroy
          render json: activity_remixed.errors, status: :unprocessable_entity
        end
      end

      # POST /gallery/v1/activities/:id/implement
      def implement
        implementation = @activity.implementations.create(person: @current_user.usereable, date_implementation: params[:date_implementation], place_implementation: params[:place_implementation], number_participants: params[:number_participants], description: params[:description])

        implementation.person_ids = params[:person_ids]

        @activity = Gallery::FunctionsActivity.reactions_activity(@activity, @current_user, auth_present?)
        render json: @activity
      end

      # GET /gallery/v1/activities/:id/likes
      def get_likes
        likes = @activity.likes

        likes = likes.page(params[:page] || 1)
        likes = likes.per(params[:per] || 10)

        render json: likes, each_serializer: Experience::V1::LikeSerializer, meta: pagination_dict(likes)
      end

      # GET /gallery/v1/activities/:id/implementations
      def get_implementations
        implementations = @activity.implementations.order(created_at: :desc)

        implementations = implementations.page(params[:page] || 1)
        implementations = implementations.per(params[:per] || 10)

        render json: implementations, each_serializer: Experience::V1::ImplementationSerializer, meta: pagination_dict(implementations)
      end

      # POST /gallery/v1/activities/:id/comment
      def comment
        @activity.comments.create(text: params[:text], person: @current_user.usereable)
        render json: @activity
      end

      # DELETE /gallery/v1/activities/:id/comment/:comment_id
      def destroy_comment
        @activity.comments.create(text: params[:text], person: @current_user.usereable)
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
        params.require(:activity).permit(
          :title,
          :caption,
          :description,
          :image,
          :motivation,
          :powerful_ideas,
          :products,
          :requirements,
          :published,
          :version_history,
          :copyright,
          :space_organization,
          :implementation_steps,
          :implementation_tips,
          :reflection_assessment,
          :duration,
          :references,
          :is_abac_author,
          :external_link,
          :inserted_by,
          :activity_type,
          :license_id,
          :specific_materials,
          external_authors: [],
          scope_ids: [],
          audience_ids: [],
          person_ids: [],
          space_type_ids: []
        )
      end
    end
  end
end
