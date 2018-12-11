class YummlyQueryBuilder
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def recipe_id
    params[:recipe_id]
  end

  def result_num(num)
    "maxResult=#{num}&start=#{num}"
  end

  def course
    "allowedCourse[]=course^course-Main%20Dishes"
  end

  def api_auth
    "_app_id=#{ENV['YUMMLY_ID']}&_app_key=#{ENV['YUMMLY_KEY']}"
  end

  def keyword
    "q=#{search_params[:keyword]}" if search_params[:keyword]
  end

  def allergies
    if validate_allergies
      @allergies ||= allergies_params.inject("") do |acc, allergy|
        if allergy_code = allergy_map[allergy.downcase]
          acc += "allowedAllergy[]=#{allergy_code}&"
        end
        acc
      end[0...-1]
    end
  end

  def cook_time_seconds
    if search_params[:max_time]
      "maxTotalTimeInSeconds=#{search_params[:max_time].to_i * 60}"
    end
  end

  def allergy_map
    {
      "wheat" => "392^Wheat-Free",
      "gluten" => "393^Gluten-Free",
      "peanut" => "394^Peanut-Free",
      "tree nut" => "395^Tree Nut-Free",
      "dairy" => "396^Dairy-Free",
      "egg" => "397^Egg-Free",
      "seafood" => "398^Seafood-Free",
      "sesame" => "399^Sesame-Free",
      "soy" => "400^Soy-Free",
      "sulfite" => "401^Sulfite-Free"
    }
  end

  private

  def search_params
    params.permit(:keyword, :max_time)
  end

  def allergies_params
    params.require(:allergies)
  end

  def validate_allergies
    params[:allergies] && params[:allergies].class == Array
  end

end
