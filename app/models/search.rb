class Search < ApplicationRecord
  validates_presence_of :keyword, :max_time, :allergies
  has_many :user_searches
  has_many :users, through: :user_searches
end
