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

    it 'returns status for success or failure' do
      expect(@iss.status).to eq(200)

      params2 = ActionController::Parameters.new({
        token: 'lklkjl',
        order: 'newest'
        })
      iss2 = IndexSearchSerializer.new(params2)
      expect(iss2.status).to eq(404)
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

    it 'can serialize_searches' do
      searches = @user.searches
      expected = @iss.serialize_searches(searches)
      expect(expected.length).to eq(2)
      expect(expected[0]).to have_key(:keyword)
      expect(expected[0]).to have_key(:max_time)
      expect(expected[0]).to have_key(:allergies)
    end

    it 'body returns ordered_searches or failure' do
      ordered = @iss.ordered_searches
      expect(@iss.body).to eq(ordered)

      params2 = ActionController::Parameters.new({
        token: 'lklkjl',
        order: 'newest'
        })
      iss2 = IndexSearchSerializer.new(params2)
      expect(iss2.body).to eq({message: "Not Found"})
    end

  end

end
