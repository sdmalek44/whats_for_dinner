require 'rails_helper'

describe 'POST /api/v1/login' do
  it 'can create a user' do
    user = create(:user)
    user_token = user.token

    headers = {
        "Content-Type": 'application/json',
        "Accept": 'application/json'
    }

    body = {
      user: {
        email: "example@example.example",
        password: 'monkeys'
      }
    }

    post '/api/v1/login', params: body.to_json, headers: headers

    user = JSON.parse(response.body, symbolize_names: true)

    expect(user[:email]).to eq(body[:user][:email])
    expect(user[:token]).to be_a(String)
  end

  it 'does not create user if password incorrect' do
    user = create(:user)
    user_token = user.token

    headers = {
        "Content-Type": 'application/json',
        "Accept": 'application/json'
    }

    body = {
      user: {
        email: "example@example.example",
        password: 'wrong'
      }
    }

    post '/api/v1/login', params: body.to_json, headers: headers

    user = JSON.parse(response.body, symbolize_names: true)

    expect(user[:message]).to eq('Bad Request')
    expect(response).to_not be_successful
  end

  it 'does not create user if user doesnt exist' do
    user = create(:user)
    user_token = user.token

    headers = {
        "Content-Type": 'application/json',
        "Accept": 'application/json'
    }

    body = {
      user: {
        email: "tommy@example.example",
        password: 'wrong'
      }
    }

    post '/api/v1/login', params: body.to_json, headers: headers

    user = JSON.parse(response.body, symbolize_names: true)

    expect(user[:message]).to eq('Bad Request')
    expect(response).to_not be_successful
  end
  
end
