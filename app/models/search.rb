class Search < ApplicationRecord
  validates_presence_of :keyword, :max_time, :allergies
end
