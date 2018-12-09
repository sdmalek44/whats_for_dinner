class Search < ApplicationRecord
  validates_presence_of :keyword, :max_time, :allergies
  has_many :user_searches
  has_many :users, through: :user_searches

  def self.newest
    joins(:user_searches).order('user_searches.updated_at DESC')
  end

  def self.oldest
    joins(:user_searches).order('user_searches.updated_at ASC')
  end

end
