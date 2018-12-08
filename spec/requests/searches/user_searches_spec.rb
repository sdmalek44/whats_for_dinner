require 'rails_helper'

describe 'POST /users/:token/searches' do
  it 'can create a new search and return search results' do
    user_password = 'monkeys'
    user = create(:user)

    headers = {
        "Content-Type": 'application/json',
        "Accept": 'application/json'
    }

    body = {
      keyword: "onions",
      allergies: ['peanut', 'dairy'],
      max_cook_time: '15'
    }

    post "/api/v1/users/#{user.token}/searches", params: body.to_json, headers: headers

    recipes = JSON.parse(response.body, symbolize_names: true)
    recipe = recipes.first

    expect(recipes.length).to eq(10)
    expect(recipe).to have_key(:name)
    expect(recipe).to have_key(:image)
    expect(recipe).to have_key(:ingredients)
    expect(recipe).to have_key(:recipe_id)
    expect(recipe).to have_key(:cook_time)
  end
end
