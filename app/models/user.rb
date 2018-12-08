class User < ApplicationRecord
  has_secure_token
  has_secure_password
  validates_presence_of :email, :password
  validates_uniqueness_of :email
  has_many :user_searches
  has_many :searches, through: :user_searches
end
