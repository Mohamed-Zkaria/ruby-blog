class Tag < ApplicationRecord
    has_many :post_tag, dependent: :destroy
    has_many :posts, through: :post_tag
end
