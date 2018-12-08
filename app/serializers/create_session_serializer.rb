class CreateSessionSerializer

  def initialize(params)
    @params = create_session_params(params)
  end

  def success
    {email: user.email, token: user.token}
  end

  def failure
    {message: 'Bad Request'}
  end

  def body
    if authenticate_user
      success
    else
      failure
    end
  end

  def status
    return 200 if authenticate_user
    400
  end

  def user
    @user ||= User.find_by_email(@params[:email])
  end

  def authenticate_user
    @authenticate ||= (user && user.authenticate(@params[:password]))
  end

  private

  def create_session_params(params)
    params.require(:user).permit(:email, :password)
  end
end
