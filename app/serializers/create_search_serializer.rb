class CreateSearchSerializer

  def initialize(params)
    @service = YummlyService.new(params)
  end

  def recipes
    @recipes ||= @service.recipes
  end

end
