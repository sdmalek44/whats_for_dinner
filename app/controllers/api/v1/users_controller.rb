class Api::V1::UsersController < ApiController

  def create
    results = CreateUserSerializer.new(params)
    render json: results.body, status: results.status
  end

end
