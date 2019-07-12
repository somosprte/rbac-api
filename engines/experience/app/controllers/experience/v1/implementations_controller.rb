# frozen_string_literal: true

require_dependency 'experience/application_controller'

module Experience
  module V1
    class ImplementationsController < ApplicationController
      before_action :set_implementation, only: %i[update destroy]

      # PATCH/PUT experience/v1/implementations/:id
      def update
        authorize @implementation
        if @implementation.update(implementation_params)
          render json: @implementation
        else
          render json: @implementation.errors, status: :unprocessable_entity
        end
      end

      # DELETE experience/v1/implementations/:id
      def destroy
        authorize @implementation
        @implementation.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_implementation
        @implementation = Implementation.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def implementation_params
        params.require(:implementation).permit(:date_implementation, :place_implementation, :number_participants, :description, person_ids: [])
      end
    end
  end
end
