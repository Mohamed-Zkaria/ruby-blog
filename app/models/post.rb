class Post < ApplicationRecord

    belongs_to :user

    validates :title, presence: true
    validates :body, presence: true, length: { minimum: 10 }

    has_many :comments, dependent: :destroy
    after_create :delete_after_time

    private

    def delete_after_time
        PostsJob.perform_in( 24.hours, id)
    end
end
