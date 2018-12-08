class Api::V1::SessionsController < ApiController

  def create
    results = CreateSessionSerializer.new(params)
    render json: results.body, status: results.status
  end

end
