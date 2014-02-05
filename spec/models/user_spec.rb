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
    let(:user){ User.create username:"pekka", password:"Secret1", password_confirmation:"Secret1" }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      rating = Rating.new score:10
      rating2 = Rating.new score:20

      user.ratings << rating
      user.ratings << rating2

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end
end
