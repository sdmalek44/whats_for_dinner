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
      minutes: (recipe_info[:totalTimeInSeconds].to_i / 60).to_i,
      image: recipe_info[:smallImageUrls]
    }
  end

  def body
    if user && create_search
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
    searches = user.searches
    if search = searches.find_by(create_search_params)
      create_relationship(user, search)
    else
      search = searches.create(create_search_params)
    end
    search.save
  end

  def create_relationship(user, search)
    UserSearch.find_or_create_by(user_id: user.id, search_id: search.id)
  end

  private

  def create_search_params
    {keyword: service.params[:keyword], allergies: allergy_params, max_time: service.params[:max_time]}
  end

  def allergy_params
    service.params[:allergies].join(', ') if service.params[:allergies]
  end

  attr_reader :service
end
