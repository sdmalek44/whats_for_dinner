class UserSearch < ApplicationRecord
  validates_presence_of :user_id, :search_id
  belongs_to :user
  belongs_to :search
end
