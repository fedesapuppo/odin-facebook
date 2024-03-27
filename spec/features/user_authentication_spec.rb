require 'rails_helper'

RSpec.feature 'User Authentication', type: :feature do
  scenario 'User signs up, logs in, and logs out' do
    visit new_user_registration_path

    fill_in 'user_email', with: 'johndoe@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')

    click_button 'Sign Out'
    expect(page).to have_content('Signed out successfully.')

    visit new_user_session_path
    fill_in 'user_email', with: 'johndoe@example.com'
    fill_in 'user_password', with: 'password'
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully.')
  end
end
