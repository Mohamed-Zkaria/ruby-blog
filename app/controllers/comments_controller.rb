class CommentsController < ApplicationController
    
    before_action :authorize_request

    def create
        begin
            @comment = Comment.new comment_params
            @comment.user_id = @current_user.id
            if @comment.save
                render json: @comment.attributes.except("user_id"), status: :created
            else
                render json: { errors: @comment.errors.full_messages },
                    status: :unprocessable_entity
            end
        rescue ActiveRecord::RecordNotFound => e
            render json: { errors: e.message }, status: :not_found
        end

    end

    private

    def comment_params
        params.permit(
          :body, :post_id
        )
    end
end