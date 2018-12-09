class YummlyService < YummlyQueryBuilder

  def initialize(params)
    super(params)
  end

  def recipes
    @recipes ||= get_json("/v1/api/recipes?#{api_auth}&#{course}&#{keyword}&#{allergies}&#{cook_time_seconds}&#{result_num(10)}")[:matches]
  end

  def recipe
    @recipe ||= get_json("/v1/api/recipe/#{recipe_id}?#{api_auth}")
  end

  def get_json(url)
    request = conn.get(url)
    if request.status == 200
      JSON.parse(request.body, symbolize_names: true)
    else
      false
    end
  end


  private

  def conn
    @conn ||= Faraday.new('https://api.yummly.com') do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.headers['Content-Type'] = 'application/json'
    end
  end

end
