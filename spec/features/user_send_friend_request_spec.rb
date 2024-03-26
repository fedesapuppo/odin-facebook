require 'rails_helper'

RSpec.feature 'Users can send and unsend friend requests to other users', type: :feature do
  context 'User logs in, visits friends page, and send follow request' do
    scenario 'User sends a friend request to another user' do
      user = create(:user)
      non_friend = create(:user)

      sign_in user
      visit friends_path
      click_button 'Send Friend Request'

      expect(page).to have_content('Friend request sent!')
      expect(page).to have_content(non_friend.name)
    end

    scenario 'User unsends a friend request to another user' do
      user = create(:user)
      non_friend = create(:user)
      friend_request = create(:friend_request, requester: user, receiver: non_friend)
      friend_requests = FriendRequest.where(requester_id: user, status: 'pending')

      sign_in user
      visit friends_path
      click_button 'Unsend Friend Request'

      expect(page).to have_content('Friend request cancelled')
    end
  end
end
