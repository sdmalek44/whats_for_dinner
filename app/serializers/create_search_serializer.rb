class CreateSearchSerializer
  attr_reader :status

  def initialize(params)
    @service = YummlyService.new(params)
    @user = User.find_by_token(params[:token])
  end

  def recipes
    @recipes ||= @service.recipes.map { |recipe_info| recipe(recipe_info)}
  end

  def failure
    {message: "Bad Request"}
  end

  def recipe(recipe_info)
    {
      name: recipe_info[:recipeName],
      recipe_id: recipe_info[:id],
      minutes: (recipe_info[:totalTimeInSeconds].to_i / 60).to_i,
      image: recipe_info[:smallImageUrls][0]
    }
  end

  def create_search
    if search = Search.find_by(create_search_params)
      create_relationship(user, search)
    else
      search = user.searches.create(create_search_params)
    end
    search.save
  end

  def request_valid?
    @valid ||= user && create_search
  end

  def body
    if request_valid?
      recipes
    else
      failure
    end
  end

  def user
    @user ||= User.find_by_token(@user_token)
  end

  def status
    if request_valid?
      200
    else
      400
    end
  end

  def create_relationship(user, search)
    UserSearch.find_or_create_by(user_id: user.id, search_id: search.id)
  end

  private

  attr_reader :service,
              :user

  def create_search_params
    {keyword: service.params[:keyword], allergies: allergy_params, max_time: service.params[:max_time]}
  end

  def allergy_params
    service.params[:allergies].join(', ') if service.params[:allergies]
  end

end
