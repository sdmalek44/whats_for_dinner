class CreateSearchSerializer
  attr_reader :status

  def initialize(params)
    @service = YummlyService.new(params)
    @user_token = params[:token]
    @status = 400
  end

  def recipes
    @recipes ||= @service.recipes.map { |recipe_info| recipe(recipe_info)}
  end

  def recipe(recipe_info)
    {
      name: recipe_info[:recipeName],
      recipe_id: recipe_info[:id],
      cook_time: (recipe_info[:totalTimeInSeconds].to_i * 60),
      image: recipe_info[:smallImageUrls]
    }
  end

  def body
    if create_search
      success
      recipes
    else
      failure
    end
  end

  def failure
    {message: "Incomplete parameters"}
  end

  def user
    @user ||= User.find_by_token(@user_token)
  end

  def success
    @status = 200
  end

  def create_search
    if user
      search = user.searches.create(keyword: service.keyword, allergies: service.allergies, max_time: service.cook_time_seconds)
    end
    search.save
  end

  private

  attr_reader :service
end
