require 'rails_helper'

RSpec.feature 'Users can remove friends', type: :feature do
  scenario 'User logs in, visits friends page, and removes a friend' do
    user = create(:user)
    friend = create(:user)
    friendship = user.friendships.create(friend:)
    friends = user.friends

    sign_in user
    visit friends_path

    expect(page).to have_content(friend.name)

    click_button 'Remove Friend'

    expect(page).to have_content('Friend removed!')
  end
end
