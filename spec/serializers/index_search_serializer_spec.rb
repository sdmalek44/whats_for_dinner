require 'rails_helper'

describe IndexSearchSerializer, type: :model do
  before(:each) do
    @user = create(:user)
    @user.searches.create(keyword: 'soup', allergies: 'dairy', max_time: 25)
    @user.searches.create(keyword: 'onion', allergies: 'dairy, peanut', max_time: 15)
    @params = ActionController::Parameters.new({
      token: @user.token,
      order: 'newest'
      })
    @iss = IndexSearchSerializer.new(@params)
  end

  context 'instance methods' do

    it 'has attributes' do
      expect(@iss.user).to eq(@user)
    end

    it 'can return failure' do
      expect(@iss.failure).to eq({message: "Not Found"})
    end

    it 'can get newest ordered searches' do
      searches = @iss.ordered_searches
      expect(searches.length).to eq(2)

      expect(searches[0][:keyword]).to eq('onion')
      expect(searches[0][:max_time]).to eq(15)
      expect(searches[0][:allergies]).to eq(['dairy', 'peanut'])
    end

    it 'can get oldest ordered searches' do
      @params2 = ActionController::Parameters.new({
        token: @user.token,
        order: 'oldest'
        })
      @iss2 = IndexSearchSerializer.new(@params2)
      searches = @iss2.ordered_searches
      expect(searches.length).to eq(2)
      expect(searches[0][:keyword]).to eq('soup')
      expect(searches[0][:max_time]).to eq(25)
      expect(searches[0][:allergies]).to eq(['dairy'])
    end

  end

end
