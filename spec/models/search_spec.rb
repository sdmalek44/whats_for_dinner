require 'rails_helper'

RSpec.describe Search, type: :model do

  describe 'validations' do
    it {should validate_presence_of :keyword}
    it {should validate_presence_of :allergies}
    it {should validate_presence_of :max_time}
  end

  describe 'relationships' do
    it {should have_many :user_searches}
    it {should have_many :users}
  end

  describe 'class methods' do
    it 'can order starting with newest' do
      user = create(:user)
      search_1 = user.searches.create(keyword: 'chicken', allergies: 'soy, dairy', max_time: 35)
      search_2 = user.searches.create(keyword: 'onion', allergies: 'soy', max_time: 15)
      newest = user.searches.newest

      expect(newest.length).to eq(2)
      expect(newest.first).to eq(search_2)
    end

    it 'can order starting with oldest' do
      user = create(:user)
      search_1 = user.searches.create(keyword: 'chicken', allergies: 'soy, dairy', max_time: 35)
      search_2 = user.searches.create(keyword: 'onion', allergies: 'soy', max_time: 15)
      oldest = user.searches.oldest

      expect(oldest.length).to eq(2)
      expect(oldest.first).to eq(search_1)
    end
  end

end
