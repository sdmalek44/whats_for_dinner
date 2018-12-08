class YummlyService

  def initialize(params)
    @params = create_search_params(params)
  end

  private

  def create_search_params(params)
    params.permit(:keyword, :allergies, :max_cook_time)
  end

end
