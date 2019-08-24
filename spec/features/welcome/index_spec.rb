require 'rails_helper'

describe 'Welcome Index' do
  it "Loads the site homepage and displays greeting" do

    visit '/'

    expect(page).to have_content('Welcome to Little Shop!')
  end
end
