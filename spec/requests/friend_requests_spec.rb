require 'rails_helper'
RSpec.describe 'FriendRequests', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:requester) { create(:user) }
  let(:receiver) { create(:user) }
  let(:friend_request) { create(:friend_request) }

  before do
    sign_in requester
  end

  describe 'POST /create' do
    context 'logged in' do
      it 'redirects to root' do
        post '/friend_requests/', params: { friend_request: { receiver_id: receiver.id } }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'not logged in' do
      it 'redirects to sign in page' do
        sign_out requester
        post '/friend_requests/', params: { friend_request: { receiver_id: receiver.id } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'logged in' do
      it 'redirects to root' do
        delete "/friend_requests/#{friend_request.id}"
        expect(response).to redirect_to(root_path)
      end
    end

    context 'not logged in' do
      it 'redirects to sign in page' do
        sign_out requester
        delete "/friend_requests/#{friend_request.id}"
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
