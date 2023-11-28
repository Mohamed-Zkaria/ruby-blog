class CommentsController < ApplicationController
    
    before_action :authorize_request
    before_action :owns_comment? , only: [:update, :destroy]
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

    def update
        @comment.body = params[:body] if params[:body]
        if @comment.save
            render json: @comment.attributes.except("user_id"), status: :created
        else
            render json: { errors: @comment.errors.full_messages },
                status: :unprocessable_entity
        end
    end

    def destroy
        if @comment.destroy
            render json: @comment.attributes.except("user_id"), status: :ok
        else
            render json: { errors: @comment.errors.full_messages },
                status: :unprocessable_entity
        end
    end

    private

    def comment_params
        params.permit(
          :body, :post_id
        )
    end
end