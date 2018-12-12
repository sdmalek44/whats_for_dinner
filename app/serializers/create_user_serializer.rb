class CreateUserSerializer

  def initialize(params)
    @params = create_user_params(params)
  end

  def user
    @user ||= User.create(@params)
  end

  def body
    if user.save
      success
    else
      failure
    end
  end

  def success
    {email: user.email, token: user.token}
  end

  def failure
    {message: 'Bad Request'}
  end

  def status
    return 200 if user.save
    400
  end

  private

  def create_user_params(params)
    params.require(:user).permit(:email, :password)
  end

end
