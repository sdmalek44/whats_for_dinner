require 'rails_helper'

describe 'GET /users/:token/searches' do

  it 'can access all users searches ordered by newest to oldest' do
    user = create(:user)
    search_1 = user.searches.create(keyword: 'chicken', allergies: 'soy, dairy', max_time: 35)
    search_2 = user.searches.create(keyword: 'onion', allergies: 'soy', max_time: 15)

    get "/users/#{user.token}/searches?order=newest"

    searches = JSON.parse(response.body, symbolize_names: true)
    search = searches.first

    expect(response).to be_successful
    expect(searches.length).to eq(2)
    expect(search[:max_time]).to eq(search_2.max_time)
    expect(search[:allergies]).to eq(search_2.allergies)
    expect(search[:max_time]).to eq(search_2.max_time)
  end

  it 'can access all users searches ordered oldest to newest' do
    user = create(:user)
    search_1 = user.searches.create(keyword: 'chicken', allergies: 'soy, dairy', max_time: 35)
    search_2 = user.searches.create(keyword: 'onion', allergies: 'soy', max_time: 15)

    get "/users/#{user.token}/searches?order=newest"

    searches = JSON.parse(response.body, symbolize_names: true)
    search = searches.first

    expect(response).to be_successful
    expect(searches.length).to eq(2)
    expect(search[:max_time]).to eq(search_1.max_time)
    expect(search[:allergies]).to eq(search_1.allergies)
    expect(search[:max_time]).to eq(search_1.max_time)
  end
end
