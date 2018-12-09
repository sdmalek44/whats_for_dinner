class ShowRecipeSerializer
  attr_reader :status

  def initialize(params)
    @service = YummlyService.new(params)
    @recipe_id = params[:recipe_id]
    @status = 200
  end

  def body
    if recipe
      serialize_recipe
    else
      failure
    end
  end

  def recipe
    @recipe ||= service.recipe
  end

  def serialize_recipe
    {
      name: recipe[:name],
      image: recipe[:images][0][:hostedLargeUrl],
      ingredients: recipe[:ingredientLines],
      servings: recipe[:numberOfServings],
      minutes: (recipe[:totalTimeInSeconds] / 60)
    }
  end

  def failure
    @status = 404
    {message: "Not Found"}
  end

  private

  attr_reader :service

end
