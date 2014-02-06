require 'spec_helper'

describe User do
  it 'has the username set correctly' do
    user = User.new username:'pekka'
    user.username.should == 'pekka'
  end

  it "won't be saved without a password" do
    user = User.create username:'pekka'
    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "won't be saved with a password that doesn't have a capital letter" do
    user = User.create username:'pekka', password:"secret1", password_confirmation:"secret1"
    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "won't be saved with a password that doesn't have a number" do
    user = User.create username:'pekka', password:"Secret", password_confirmation:"Secret"
    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "won't be saved with a password that doesn't have a lowercase letter" do
    user = User.create username:'pekka', password:"SECRET1", password_confirmation:"SECRET1"
    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "won't be saved with a too short password" do
    user = User.create username:'pekka', password:"Ab1", password_confirmation:"Ab1"
    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end
end

describe "User's favorite style" do
  let(:user){ FactoryGirl.create(:user) }

  it "method exists" do
    user.should respond_to :favorite_beer
  end

  it "returns nil if they have no ratings" do
    user.favorite_beer.should eq(nil)
  end

  it "returns correctly if there is one rating" do
    beer = create_beer_with_rating(5, user)

    user.favorite_style.should eq(beer.style)
  end

  it "returns correctly if there are many ratings" do
    create_beers_with_ratings(10, 5, 15, 31, 1, 20, user)
    best = create_beer_with_rating(50, user)
    best.style = "Weizen" #default "Lager"
    best.save
    create_beers_with_ratings(21, 35, user)
    user.favorite_style.should eq(best.style)
    user.favorite_style.should_not eq("Lager")
  end
end

describe "User's favorite beer" do
  let(:user){ FactoryGirl.create(:user) }

  it "method exists" do
    user.should respond_to :favorite_beer
  end

  it "returns nil if they have no ratings" do
    user.favorite_beer.should eq(nil)
  end

  it "returns correctly if there is one rating" do
    beer = create_beer_with_rating(5, user)

    user.favorite_beer.should eq(beer)
  end

  it "returns correctly if there are many ratings" do
    create_beers_with_ratings(10, 5, 15, 31, 1, 20, user)
    best = create_beer_with_rating(50, user)
    create_beers_with_ratings(21, 35, user)
    user.favorite_beer.should eq(best)
  end
end

def create_beer_with_rating(score, user)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  beer
end

def create_beers_with_ratings(*scores, user)
  scores.each do |score|
    create_beer_with_rating(score, user)
  end
end
