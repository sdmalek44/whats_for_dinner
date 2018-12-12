class YummlyService
  include(YummlyQueryBuilder)
  
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def recipes
    @recipes ||= get_json(
                  "/v1/api/recipes?#{api_auth}&#{course_main}"\
                  "&#{keyword(search_params[:keyword])}"\
                  "&#{allergies(allergies_params)}"\
                  "&#{cook_time_seconds(search_params[:max_time])}"\
                  "&#{result_num(10)}")[:matches]
  end

  def recipe
    @recipe ||= get_json("/v1/api/recipe/#{params[:recipe_id]}?#{api_auth}")
  end

  def get_json(url)
    request = conn.get(url)
    return JSON.parse(request.body, symbolize_names: true) if request.success?
    false
  end


  private

  attr_reader :recipe_id

  def conn
    @conn ||= Faraday.new('https://api.yummly.com') do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.headers['Content-Type'] = 'application/json'
    end
  end

  def search_params
    params.permit(:keyword, :max_time)
  end

  def allergies_params
    params.require(:allergies)
  end

end
