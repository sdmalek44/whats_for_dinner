require 'rails_helper'

describe 'GET /users/:token/searches' do

  it 'can access all users searches ordered by newest to oldest' do
    VCR.use_cassette('newest-search') do
      user = create(:user)
      search_1 = user.searches.create(keyword: 'chicken', allergies: 'soy, dairy', max_time: 35)
      search_2 = user.searches.create(keyword: 'onion', allergies: 'soy', max_time: 15)

      get "/api/v1/users/#{user.token}/searches?order=newest"

      searches = JSON.parse(response.body, symbolize_names: true)
      search = searches.first

      expect(response).to be_successful
      expect(searches.length).to eq(2)
      expect(search[:max_time]).to eq(search_2.max_time)
      expect(search[:allergies]).to eq(search_2.allergies.split(', '))
      expect(search[:keyword]).to eq(search_2.keyword)
    end
  end

  it 'can access all users searches ordered oldest to newest' do
    VCR.use_cassette('oldest-search') do
      user = create(:user)
      search_1 = user.searches.create(keyword: 'chicken', allergies: 'soy, dairy', max_time: 35)
      search_2 = user.searches.create(keyword: 'onion', allergies: 'soy', max_time: 15)

      get "/api/v1/users/#{user.token}/searches?order=oldest"

      searches = JSON.parse(response.body, symbolize_names: true)
      search = searches.first

      expect(response).to be_successful
      expect(searches.length).to eq(2)
      expect(search[:max_time]).to eq(search_1.max_time)
      expect(search[:allergies]).to eq(search_1.allergies.split(', '))
      expect(search[:keyword]).to eq(search_1.keyword)
    end
  end

  it 'can access all users searches not ordered' do
    VCR.use_cassette('not-ordered-searches') do
      user = create(:user)
      search_1 = user.searches.create(keyword: 'chicken', allergies: 'soy, dairy', max_time: 35)
      search_2 = user.searches.create(keyword: 'onion', allergies: 'soy', max_time: 15)

      get "/api/v1/users/#{user.token}/searches"

      searches = JSON.parse(response.body, symbolize_names: true)
      search = searches.first

      expect(response).to be_successful
      expect(searches.length).to eq(2)
      expect(search[:max_time]).to eq(search_1.max_time)
      expect(search[:allergies]).to eq(search_1.allergies.split(', '))
      expect(search[:keyword]).to eq(search_1.keyword)
    end
  end

  it 'returns 404 if no user found' do
      VCR.use_cassette('search-not-found') do

      get "/api/v1/users/0980324jkjlkj/searches?order=oldest"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)
      expect(result[:message]).to eq("Not Found")
    end
  end
end
