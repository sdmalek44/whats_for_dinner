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
end