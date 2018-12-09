require 'rails_helper'

describe 'GET /api/v1/recipe/:recipe_id' do
  it 'can get a single recipe and all ingredients' do
    get '/api/v1/recipes/Quick-chicken-enchilada-soup-350936'

    recipe = JSON.parse(response.body, symbolize_names: true)

    expect(recipe[:name]).to eq("Quick Chicken Enchilada Soup")
    expect(recipe[:ingredients].length).to eq(9)
    expect(recipe[:image]).to eq("http://lh4.ggpht.com/IVpIyL7sXXwoG8tl6lKKyY7vvDR7aLI4Ro40xhEwrh5EFgjk4yBXyaL0NeERBYZaPq0GfY_0cTbG_VoDW2PcTCk=s360")
    expect(recipe[:servings]).to eq(4)
    expect(recipe[:minutes]).to eq(25)
  end
end
