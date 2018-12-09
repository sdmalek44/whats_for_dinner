require 'rails_helper'

describe 'POST /api/v1/users' do
  it 'can create a user' do
    headers = {
        "Content-Type": 'application/json',
        "Accept": 'application/json'
    }

    body = {
      user: {
        email: "example@example.example",
        password: 'monkeys',
      }
    }

    post '/api/v1/users', params: body.to_json, headers: headers

    user = JSON.parse(response.body, symbolize_names: true)

    expect(user[:email]).to eq(body[:user][:email])
    expect(user[:token]).to be_a(String)
  end

  it 'returns error if bad request' do
    headers = {
        "Content-Type": 'application/json',
        "Accept": 'application/json'
    }

    body = {
      user: {
        email: "example@example.example"
      }
    }

    post '/api/v1/users', params: body.to_json, headers: headers

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result[:message]).to eq("Bad Request")
    expect(response).to_not be_successful
  end
  
end
