class PostsController < ApplicationController

    before_action :authorize_request
    before_action :owns_post? , only: [:update, :destroy]

    def index
        render json: {posts: Post.all}
    end

    def create
        @post = Post.new(post_params.except(:tags))
        @post.user_id = @current_user.id
        create_or_delete_post_tags(@post, params[:tags])
        if @post.save
            render json: @post.attributes.except("user_id"), status: :created
        else
            render json: { errors: @post.errors.full_messages },
                status: :unprocessable_entity
        end
    end

    def update
        @post.title = params[:title] if params[:title]
        @post.body = params[:body] if params[:body]
        create_or_delete_post_tags(@post, params[:tags])
        if @post.save
            render json: @post.attributes.except("user_id"), status: :created
        else
            render json: { errors: @post.errors.full_messages },
                status: :unprocessable_entity
        end
    end

    def destroy
        if @post.destroy
            render json: @post.attributes.except("user_id"), status: :ok
        else
            render json: { errors: @post.errors.full_messages },
                status: :unprocessable_entity
        end
    end
    
    private
    def post_params
        params.permit(
          :title, :body, :tags
        )
    end

    def create_or_delete_post_tags(post, tags)
        post.post_tag.destroy_all
        tags = tags.strip.split(",")
        tags.each do |tag|
            post.tags << Tag.find_or_create_by(name: tag)
        end    
    end
end