require 'spec_helper'

describe 'Beer' do
  before :each do
    FactoryGirl.create(:brewery)
  end

  describe "when user is logged in" do
    before :each do
      FactoryGirl.create(:user)
      sign_in(username:'Pekka', password:'Foobar1')
    end

    it 'beer with a proper name can be saved through the beers view' do
      visit new_beer_path
      fill_in('beer_name', with:'kalia')
      click_button 'Create Beer'
      expect(current_path).to eq(beers_path)
      expect(page).to have_content 'kalia'
    end

    it "beer without a proper name won't be saved through the beers view" do
      visit new_beer_path
      click_button 'Create Beer'
      expect(page).to have_content "Name can't be blank"
      expect(Beer.count).to eq(0)
    end
  end
end