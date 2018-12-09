class RecipesController < ApiController

  def show
    results = ShowRecipeSerializer.new(params)
    render json: results.body, status: results.status
  end

end
