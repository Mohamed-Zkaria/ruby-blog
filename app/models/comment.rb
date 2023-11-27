class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post

    validates :user_id, presence: true
    validates :body, presence: true, length: { minimum: 10 }
end
