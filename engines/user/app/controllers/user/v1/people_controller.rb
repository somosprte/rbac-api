# frozen_string_literal: true

require_dependency 'user/application_controller'

module User
  module V1
    class PeopleController < ApplicationController
      before_action :set_person, only: [:show, :get_others_users_activities]
      skip_before_action :authenticate, only: [:index]

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

      # Get /user/v1/people/current_user/activities
      def get_people_activities
        current_users_activities = Gallery::Activity.get_users_activities(@current_user.usereable_id)
        current_users_activities = current_users_activities.page(params[:page] || 1)
        current_users_activities = current_users_activities.per(params[:per] || 10)
        render json: current_users_activities, each_serializer: Gallery::V1::ActivitySerializer, meta: pagination_dict(current_users_activities)
      end

      # Get /user/v1/people/:id/activities
      def get_others_users_activities
        others_users_activities = Gallery::Activity.get_users_activities(@person.id, @current_user.usereable_id == @person.id)
        others_users_activities = others_users_activities.page(params[:page] || 1)
        others_users_activities = others_users_activities.per(params[:per] || 10)
        render json: others_users_activities, each_serializer: Gallery::V1::ActivitySerializer, meta: pagination_dict(others_users_activities)
      end

      # GET /user/v1/people/favorites/activities
      def get_favorites_activities
        favorite_activities = Gallery::Activity.get_activity_favorites(@current_user.usereable)

        favorite_activities = favorite_activities.page(params[:page] || 1)
        favorite_activities = favorite_activities.per(params[:per] || 10)

        render json: favorite_activities, each_serializer: Gallery::V1::ActivitySerializer, meta: pagination_dict(favorite_activities)
      end

      # GET /user/v1/people/implementations/activities
      def get_implementations_activities
        # implementation_activities = Gallery::Activity.get_activity_implementations(@current_user.usereable).order(created_at: :desc)
        implementation_activities = Gallery::Activity
                                    .joins(implementations: :exp_people)
                                    .where("experience_exp_people.person_id = '#{@current_user.usereable.id}'")
                                    .order(created_at: :desc)
        implementation_activities = implementation_activities.page(params[:page] || 1)
        implementation_activities = implementation_activities.per(params[:per] || 10)

        render json: implementation_activities, each_serializer: Gallery::V1::ActivitySerializer, meta: pagination_dict(implementation_activities)
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
