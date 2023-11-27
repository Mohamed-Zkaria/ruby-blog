class User < ApplicationRecord

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, format: URI::MailTo::EMAIL_REGEXP
    validates :password, length: { minimum: 8 } , if: -> { new_record? || !password.nil? }
    validates :image, presence: true # image will be uploaded to a storage hosting service. for now will mock it as string only.

    has_secure_password
end
