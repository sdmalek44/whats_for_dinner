class YummlyService

  def initialize(params)
    @params = params
  end

  def recipes
    @recipes ||= get_json("/v1/api/recipes?#{api_auth}&#{course}&#{keyword}&#{allergies}&#{cook_time_seconds}&#{result_num(10)}")[:matches]
  end

  def api_auth
    "_app_id=#{ENV['YUMMLY_ID']}&_app_key=#{ENV['YUMMLY_KEY']}"
  end

  def result_num(num)
    "maxResult=#{num}&start=#{num}"
  end

  def course
    "allowedCourse[]=course^course-Main%20Dishes"
  end

  def keyword
    "q=#{search_params[:keyword]}" if search_params[:keyword]
  end

  def allergies
    if validate_allergies
      allergies_params.inject("") do |acc, allergy|
        if allergy_code = allergy_map[allergy.downcase]
          acc += "allowedAllergy[]=#{allergy_code}&"
        end
        acc
      end[0...-1]
    end
  end

  def cook_time_seconds
    if search_params[:max_cook_time]
      "maxTotalTimeInSeconds=#{search_params[:max_cook_time].to_i * 60}"
    end
  end

  def allergy_map
    {
      "wheat" => "392^Wheat-Free",
      "gluten" => "393^Gluten-Free",
      "peanut" => "394^Peanut-Free",
      "tree_nut" => "395^Tree Nut-Free",
      "dairy" => "396^Dairy-Free",
      "egg" => "397^Egg-Free",
      "seafood" => "398^Seafood-Free",
      "sesame" => "399^Sesame-Free",
      "soy" => "400^Soy-Free",
      "sulfite" => "401^Sulfite-Free"
    }
  end

  def get_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end

  private

  attr_reader :params

  def search_params
    params.permit(:keyword, :max_cook_time)
  end

  def allergies_params
    params.require(:allergies)
  end

  def validate_allergies
    params[:allergies] && params[:allergies].class == Array
  end

  def conn
    @conn ||= Faraday.new('https://api.yummly.com') do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.headers['Content-Type'] = 'application/json'
    end
  end

end
