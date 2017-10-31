require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  before(:each) do
    visit new_user_url
    fill_in 'Username', with: 'l'
    fill_in 'Password', with: 'asdfasd'
    click_on 'Create User'
  end
  feature 'signing up a user' do
    scenario 'shows username on the homepage after signup' do
      visit users_url
      expect(page).to have_content 'l'
    end
  end
  feature 'logging in' do
    scenario 'shows username on the homepage after login' do
      visit new_session_url
      fill_in 'Username', with: 'l'
      fill_in 'Password', with: 'asdfasd'
      click_on 'Sign In'

      expect(page).to have_content 'l'
    end
    feature 'logging out' do
      scenario 'begins with a logged out state'

      scenario 'doesn\'t show username on the homepage after logout'

    end

  end
end
