module YummlyQueryBuilder

  def result_num(num)
    "maxResult=#{num}&start=#{num}"
  end

  def course_main
    "allowedCourse[]=course^course-Main%20Dishes"
  end

  def api_auth
    "_app_id=#{ENV['YUMMLY_ID']}&_app_key=#{ENV['YUMMLY_KEY']}"
  end

  def keyword(k)
    "q=#{k}" if k
  end

  def allergies(allergies_arr)
    if validate_allergies(allergies_arr)
      allergies_arr.inject("") do |acc, allergy|
        if allergy_code = allergy_map[allergy.downcase]
          acc += "allowedAllergy[]=#{allergy_code}&"
        end
        acc
      end[0...-1]
    end
  end

  def cook_time_seconds(cook_time)
    if cook_time
      "maxTotalTimeInSeconds=#{cook_time.to_i * 60}"
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

  def validate_allergies(allergies)
    allergies && allergies.class == Array
  end

end
