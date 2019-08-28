require 'rails_helper'

describe 'Merchant New Page', type: :feature do
  before :each do
    @name = "Sal's Calz(ones)"
    @address = '123 Kindalikeapizza Dr.'
    @city = "Denver"
    @state = "CO"
    @zip = 80204
  end
  describe 'As a user' do
    it 'I can create a new merchant' do
      visit '/merchants/new'

      fill_in :name, with: @name
      fill_in :address, with: @address
      fill_in :city, with: @city
      fill_in :state, with: @state
      fill_in :zip, with: @zip

      click_button "Create Merchant"

      new_merchant = Merchant.last

      expect(current_path).to eq("/merchants/#{new_merchant.id}")
      expect(page).to have_content(@name)
      expect(new_merchant.name).to eq(@name)
      expect(new_merchant.address).to eq(@address)
      expect(new_merchant.city).to eq(@city)
      expect(new_merchant.state).to eq(@state)
      expect(new_merchant.zip).to eq(@zip)
    end

    it "an error is displays if the merchant was not created" do
      visit '/merchants/new'

      fill_in :name, with: @name
      fill_in :address, with: @address
      fill_in :city, with: @city
      fill_in :state, with: @state

      click_button "Create Merchant"

      expect(current_path).to eq('/merchants/new')
      expect(page).to have_content("Zip can't be blank")
    end
  end
end
