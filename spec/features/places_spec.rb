require 'spec_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:name => "Oljenkorsi", id: 1, city: 'kumpula') ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it 'if two are returned by the API both are shown at the page' do
    BeermappingApi.stub(:places_in).with("hesa").and_return(
        [ Place.new(:name => "Oljenkorsi", id: 1, city: 'hesa'), Place.new(:name => "kaljapaikka", id: 2, city: 'hesa') ]
    )
    visit places_path
    fill_in('city', with: 'hesa')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "kaljapaikka"
  end

  it 'if no places are returned by the API a notice is shown at the page' do
    BeermappingApi.stub(:places_in).with("lappi").and_return(
        []
    )
    visit places_path
    fill_in('city', with: 'lappi')
    click_button "Search"

    expect(page).to have_content "No locations in lappi"
  end

end