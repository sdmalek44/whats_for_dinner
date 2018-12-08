class CreateSearchSerializer

  def initialize(params)
    @service = YummlyService.new(params)
  end

  def recipes
    @recipes ||= @service.recipes.map { |recipe_info| recipe(recipe_info)}
  end

  def recipe(recipe_info)
    {
      name: recipe_info[:recipeName],
      recipe_id: recipe_info[:id],
      cook_time: (recipe_info[:totalTimeInSeconds].to_i * 60),
      image: recipe_info[:smallImageUrls]
    }
  end

  def body
    recipes
  end

  def status
    200
  end

  private

  attr_reader :service
end
