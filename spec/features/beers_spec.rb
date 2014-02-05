require 'spec_helper'

describe 'Beer' do
  before :each do
    FactoryGirl.create(:brewery)
  end

  it 'with a proper name can be saved through the beers view' do
    visit beers_path
    click_link 'New Beer'
    fill_in('beer_name', with:'kalia')
    click_button 'Create Beer'
    expect(current_path).to eq(beers_path)
    expect(page).to have_content 'kalia'
  end

  it "without a proper name won't be saved through the beers view" do
    visit beers_path
    click_link 'New Beer'
    click_button 'Create Beer'
    expect(page).to have_content "Name can't be blank"
    expect(Beer.count).to eq(0)
  end
end