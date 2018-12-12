require 'rails_helper'

describe CreateUserSerializer, type: :model do
  before(:each) do
    @params = ActionController::Parameters.new({
      "user": {
        "email": "bobjones@email.com",
        "password": "bobbytime"
      }
    })
    @cus = CreateUserSerializer.new(@params)
  end

  context 'instance methods' do
    it 'can create and present user' do
      expect(@cus.user.email).to eq("bobjones@email.com")
      expect(@cus.user.token).to be_a(String)
    end

    it 'can serialize success and failure messages' do
      expect(@cus.success[:email]).to eq("bobjones@email.com")
      expect(@cus.success[:token]).to be_a(String)
      expect(@cus.failure[:message]).to eq("Bad Request")
    end

    it 'can return a status' do
      json = {
        user:{
          email: ''
        }
      }
      bad_cus = CreateUserSerializer.new(ActionController::Parameters.new(json))

      expect(@cus.status).to eq(200)
      expect(bad_cus.status).to eq(400)
    end
  end
end
