require 'rails_helper'

RSpec.describe 'FriendRequests', type: :request do
  include Devise::Test::IntegrationHelpers

  describe 'POST /create' do
    context 'logged in' do
      it 'redirects to root' do
        user = create(:user)
        sign_in user
        post '/friend_requests/', params: { friend_request: { receiver_id: user.id } }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'not logged in' do
      it 'redirects to sign in page' do
        post '/friend_requests/', params: { friend_request: { receiver_id: 1 } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
