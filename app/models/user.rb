class User < ApplicationRecord
  has_secure_password
  validates :username, presence: { message: "Please specify username." }
  validates :username, uniqueness: { message: "User with specified username exists." }
  validates :password, presence: { message: "Please specify your password." }
  validates :password, length: { in: 8..20, message: "Your password should have at least 8 characters and at most 20 characters." }
  validates :email, presence: { message: "Please specify email address." }
  validates :email, uniqueness: { message: "User with specified email address exists." }

  default_scope -> { order("created_at ASC") }
end
