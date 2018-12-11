class IndexSearchSerializer

  def initialize(params)
    @params = index_search_params(params)
  end

  def user
    @user ||= User.find_by_token(@params[:token])
  end

  def body
    return ordered_searches if user
    failure
  end

  def failure
    {message: "Not Found"}
  end

  def status
    return 200 if user
    404
  end

  def ordered_searches
    if @params[:order] == 'oldest'
      return serialize_searches(user.searches.oldest)
    elsif @params[:order] == 'newest'
      return serialize_searches(user.searches.newest)
    end
    serialize_searches(user.searches)
  end

  def serialize_searches(searches)
    searches.map do |search|
      {
        keyword: search.keyword,
        max_time: search.max_time,
        allergies: search.allergies.split(', ')
      }
    end
  end

  private

  def index_search_params(params)
    params.permit(:token, :order)
  end

end
