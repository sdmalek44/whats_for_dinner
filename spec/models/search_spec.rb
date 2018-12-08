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

end
