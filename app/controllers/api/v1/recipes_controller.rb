class Api::V1::RecipesController < ApiController

  def show
    results = ShowRecipeSerializer.new(params)
    render json: results.body, status: results.status
  end

end
