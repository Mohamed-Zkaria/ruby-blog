class PostsJob
    include Sidekiq::Worker

    def perform(post_id)
        Post.find(post_id).destroy
    end
end