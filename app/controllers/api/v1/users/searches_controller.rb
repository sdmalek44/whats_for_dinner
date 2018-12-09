class Api::V1::Users::SearchesController < ApiController

  def create
    results = CreateSearchSerializer.new(params)
    render json: results.body, status: results.status
  end

  def index
    results = IndexSearchSerializer.new(params)
    render json: results.body, status: results.status
  end
  
end
