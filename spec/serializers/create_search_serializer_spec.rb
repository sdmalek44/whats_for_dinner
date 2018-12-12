require 'rails_helper'

describe CreateSearchSerializer, type: :model do
  before(:each) do
    @params = ActionController::Parameters.new({
      keyword: 'soup',
      allergies: ['dairy'],
      max_time: 25,
      recipe_id: 'Quick-chicken-enchilada-soup-350936'
    })

    @css = CreateSearchSerializer.new(@params)
  end
  context 'instance methods' do
    it 'can change a recipes keys' do
      input = {
        recipeName: 'bob',
        id: 'jill',
        totalTimeInSeconds: 5,
        smallImageUrls: 'www.picture.com'
      }

      expected = {
        name: input[:recipeName],
        recipe_id: input[:id],
        minutes: (input[:totalTimeInSeconds].to_i / 60).to_i,
        image: input[:smallImageUrls][0]
      }

      expect(@css.recipe(input)).to eq(expected)
    end

    it 'can get recipes' do
      VCR.use_cassette('recipes-create-search') do
        recipes = @css.recipes
        recipe = recipes.first
        expect(recipes.length).to eq(10)
        expect(recipe[:name]).to eq('Asian Noodle Soup with Shrimp and Wontons')
        expect(recipe[:recipe_id]).to eq('Asian-Noodle-Soup-with-Shrimp-and-Wontons-2236466')
        expect(recipe[:minutes]).to eq(15)
        expect(recipe[:image]).to eq('https://lh3.googleusercontent.com/Rl2e478Wh6_1Jiu5DBUGwiJlWdgtvtDgv_wE6vmqBN15tICwPGQHdlAniYEhVXBlUrRwsoUMnM1SVqw9mznQzGE=s90')
      end
    end
  end
end
