require 'rails_helper'

RSpec.feature 'Users can accept or reject friend requests', type: :feature do
  scenario 'User logs in, visits notifications page, and accepts a friend request' do
    user = create(:user)
    non_friend = create(:user)
    friend_request = create(:friend_request, requester: non_friend, receiver: user)
    friend_requests = FriendRequest.where(requester_id: non_friend, status: 'pending')

    sign_in user
    visit notifications_path

    expect(page).to have_content(non_friend.name)

    click_button 'Accept'

    expect(page).to have_content('Friend request accepted!')
  end

  scenario 'User logs in, visits notifications page, and rejects a friend request' do
    user = create(:user)
    non_friend = create(:user)
    friend_request = create(:friend_request, requester: non_friend, receiver: user)
    friend_requests = FriendRequest.where(requester_id: non_friend, status: 'pending')

    sign_in user
    visit notifications_path

    expect(page).to have_content(non_friend.name)

    click_button 'Reject'

    expect(page).to have_content('Friend request rejected!')
  end
end
