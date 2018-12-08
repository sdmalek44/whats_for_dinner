class YummlyService

  def initialize(params)
    @params = create_search_params(params)
  end

  def recipes
    @recipes ||= get_json("#{api_auth}&#{course}&#{keyword}&#{allergies}&#{result_num(10)}")
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
    "q=#{params[:keyword]}"
  end

  def allergies
    params[:allergies].inject("") do |acc, allergy|
      acc += "allowedAllergy[]=#{allergy_code}&" if allergy_code = allergy_map[allergy.downcase]
      acc
    end[0...-1]
  end

  def

  def allery_map
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
    JSON.parse(conn.get(url), symbolize_names: true)
  end

  private

  attr_reader :params

  def create_search_params(params)
    params.permit(:keyword, :allergies, :max_cook_time)
  end

  def conn
    @conn ||= Faraday.new('https://api.yummly.com') do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

end
