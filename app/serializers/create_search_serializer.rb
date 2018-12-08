class CreateSearchSerializer

  def initialize(params)
    @service = YummlyService.new(params)
  end

  def recipes
    @recipes ||= @service.recipes
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
