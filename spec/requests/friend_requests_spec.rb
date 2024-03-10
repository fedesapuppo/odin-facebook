require 'rails_helper'

RSpec.describe 'FriendRequests', type: :request do
  include Devise::Test::IntegrationHelpers
  describe 'POST /create' do
    it 'returns http success' do
      user = create(:user)
      sign_in user
      post '/friend_requests/create', params: { friend_request: { receiver_id: user.id } }
      expect(response).to redirect_to(root_path)
    end
  end
end
