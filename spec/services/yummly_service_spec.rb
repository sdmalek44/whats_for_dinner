require 'rails_helper'

describe 'Yummly Service' do
  before(:each) do
    params = ActionController::Parameters.new({
      keyword: 'soup',
      allergies: ['dairy'],
      max_time: 25,
      recipe_id: 'Quick-chicken-enchilada-soup-350936'
    })

    @ys = YummlyService.new(params)
  end

  context 'instance methods' do

    it 'can get recipes from parameters given' do
      VCR.use_cassette('recipe-search-service') do
        recipes = @ys.recipes
        recipe = recipes.first

        expect(recipes.length).to eq(10)
        expect(recipe).to have_key(:recipeName)
        expect(recipe).to have_key(:id)
        expect(recipe).to have_key(:totalTimeInSeconds)
        expect(recipe).to have_key(:smallImageUrls)
      end
    end

    it 'can get a single recipe' do
      VCR.use_cassette('single-recipe-service') do
        recipe = @ys.recipe

        expect(recipe).to have_key(:name)
        expect(recipe).to have_key(:images)
        expect(recipe[:images][0]).to have_key(:hostedLargeUrl)
        expect(recipe).to have_key(:numberOfServings)
        expect(recipe).to have_key(:totalTimeInSeconds)
      end
    end

  end

end
