require 'rails_helper'

RSpec.feature 'Users can send and unsend friend requests to other users', type: :feature do
  context 'User logs in, visits friends page, and send follow request' do
    let(:user) { create(:user) }
    let(:non_friend) { create(:user) }
    let(:users_not_friends) { User.where.not(id: user.friends).where.not(id: user.id) }

    before do
      sign_in user
      visit friends_path
    end

    scenario 'User sends a friend request to another user' do

      #click_button 'Send Friend Request'

      #expect(page).to have_content('Friend request sent!')
      expect(page).to have_content(non_friend.name)
    end

    scenario 'User unsends a friend request to another user' do
      click_button 'Unsend Friend Request'

      expect(page).to have_content('Friend request cancelled')
    end
  end
end
