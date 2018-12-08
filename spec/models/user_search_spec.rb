require 'rails_helper'

RSpec.describe UserSearch, type: :model do

  describe 'relationships' do
    it {should belong_to :user}
    it {should belong_to :search}
  end

  describe 'validations' do
    it {should validate_presence_of :user_id}
    it {should validate_presence_of :search_id}
  end

end
