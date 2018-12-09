require 'rails_helper'

describe 'user visits /' do
  it 'sees welcome message and link to documentation' do
    visit '/'

    expect(page).to have_content('Welcome to the WhatsForDinner API')
    expect(page).to have_link('Click Here for Documentation')
  end
end
