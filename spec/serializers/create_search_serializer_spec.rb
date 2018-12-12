require 'rails_helper'

describe CreateSearchSerializer, type: :model do
  before(:each) do
    @user = create(:user)
    @params = ActionController::Parameters.new({
      keyword: 'soup',
      allergies: ['dairy'],
      max_time: 25,
      recipe_id: 'Quick-chicken-enchilada-soup-350936',
      token: @user.token
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

    it 'can create search in database' do
      expect(User.first.searches.length).to eq(0)

      expect(@css.create_search).to be(true)
      expect(User.first.searches.length).to eq(1)
    end

    it 'can create relationship to search if search already exists' do
      @css.create_search

      user_2 = User.create(email: 'bob@bob.bob', password: 'sand')
      params_2 = ActionController::Parameters.new({
        keyword: 'soup',
        allergies: ['dairy'],
        max_time: 25,
        recipe_id: 'Quick-chicken-enchilada-soup-350936',
        token: user_2.token
      })

      css_2 = CreateSearchSerializer.new(params_2)
      css_2.create_search

      expect(@user.searches.first).to eq(user_2.searches.first)
      expect(UserSearch.all.length).to eq(2)
    end

    it 'returns body and status of request if valid' do
      expect(@css.body[0][:name]).to eq('Asian Noodle Soup with Shrimp and Wontons')
      expect(@css.status).to eq(200)
    end

    it 'returns bad request and 400 if invalid' do
      params = ActionController::Parameters.new({
        keyword: 'soup',
        allergies: ['dairy'],
        max_time: 25,
        recipe_id: 'Quick-chicken-enchilada-soup-350936',
        token: 'WRONG TOKEN'
      })
      css = CreateSearchSerializer.new(params)

      expect(css.body[:message]).to eq('Bad Request')
      expect(css.status).to eq(400)
    end

    it 'can create a relationship in user search table' do
      search = create(:search)

      expect(UserSearch.all.length).to eq(0)

      @css.create_relationship(@user, search)
      expect(UserSearch.all.length).to eq(1)
    end
  end
end
