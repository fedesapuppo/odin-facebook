require 'rails_helper'

RSpec.describe 'FriendshipAcknowledgements', type: :request do
  include Devise::Test::IntegrationHelpers

  describe 'POST /create' do
    context 'when logged in' do
      it 'redirects to notifications path' do
        user = create(:user)
        friend_request = create(:friend_request)
        sign_in user
        post '/friendship_acknowledgements', params: { friend_request: { friend_request_id: friend_request.id } }
        expect(response).to redirect_to(notifications_path)
      end
    end

    context 'when not logged in' do
      it 'redirects to sign in page' do
        friend_request = create(:friend_request)
        post '/friendship_acknowledgements', params: { friend_request: { friend_request_id: friend_request.id } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'when logged in' do
      it 'redirects to notifications path' do
        user = create(:user)
        friend_request = create(:friend_request)
        friendship_acknowledgement = create(:friendship_acknowledgement)
        sign_in user
        delete "/friendship_acknowledgements/#{friendship_acknowledgement.id}", params: { friend_request: { friend_request_id: friend_request.id } }
        expect(response).to redirect_to(notifications_path)
      end
    end

    context 'when not logged in' do
      it 'redirects to sign in page' do
        friendship_acknowledgement = create(:friendship_acknowledgement)
        delete "/friendship_acknowledgements/#{friendship_acknowledgement.id}"
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
