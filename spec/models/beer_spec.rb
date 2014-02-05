require 'spec_helper'

describe Beer do
  it "will be saved when it has a proper name and style" do
    beer = Beer.create name:'kalia', style:'Lager'
    expect(beer.valid?).to eq(true)
    expect(Beer.count).to eq(1)
  end

  it "won't be saved when it doesn't have a name" do
    beer = Beer.create style:'Lager'
    expect(beer.valid?).to eq(false)
    expect(Beer.count).to eq(0)
  end

  it "won't be saved when it doesn't have a style" do
    beer = Beer.create name:'kalia'
    expect(beer.valid?).to eq(false)
    expect(Beer.count).to eq(0)
  end
end
