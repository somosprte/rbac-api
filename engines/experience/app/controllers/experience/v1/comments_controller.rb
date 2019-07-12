# frozen_string_literal: true

require_dependency 'experience/application_controller'

module Experience
  module V1
    class CommentsController < ApplicationController
      before_action :set_comment, only: %i[update destroy]

      # PATCH/PUT experience/v1/comments/:id
      def update
        authorize @comment
        if @comment.update(comment_params)
          render json: @comment
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      # DELETE experience/v1/comments/:id
      def destroy
        authorize @comment
        @comment.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_comment
        @comment = Comment.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def comment_params
        params.require(:comment).permit(:text)
      end
    end
  end
end
