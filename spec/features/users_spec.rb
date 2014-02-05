require 'spec_helper'

describe "User" do
  before :each do
    @pekka = FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can sign in with right credentials" do
      sign_in(username:'Pekka', password:'Foobar1')

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end
    it "is redirected back to sign in form if wrong credentials given" do
      sign_in(username:'Pekka', password:'wrong')

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'User and password do not match'
    end
  end

  it "who tries to sign up with good credentials is saved" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  it "should show only their ratings on their page" do
    beer1 = FactoryGirl.create(:beer)
    beer2 = FactoryGirl.create(:beer)
    jonne = FactoryGirl.create(:user, username:'jonne')
    FactoryGirl.create(:rating, beer:beer1, user:jonne)
    FactoryGirl.create(:rating, beer:beer2, user:@pekka)
    visit user_path(jonne)
    expect(page).to have_content 'Has made 1 rating'
  end
end