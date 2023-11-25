class User < ApplicationRecord

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, format: URI::MailTo::EMAIL_REGEXP
    validates :password, length: { minimum: 8 }, presence: true
    validates :image, presence: true
end
