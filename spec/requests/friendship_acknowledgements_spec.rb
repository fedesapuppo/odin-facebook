require 'rails_helper'

RSpec.describe 'FriendshipAcknowledgements', type: :request do
  include Devise::Test::IntegrationHelpers
  describe 'POST /create' do
    it 'redirects to notifications path' do
      user = create(:user)
      friend_request = create(:friend_request)
      sign_in user
      post '/friendship_acknowledgements', params: { friend_request: friend_request.id }
      expect(response).to redirect_to(notifications_path)
    end
  end

  describe 'DELETE /destroy' do
    it 'redirects to notifications path' do
      user = create(:user)
      sign_in user
      friendship_acknowledgement = create(:friendship_acknowledgement)
      delete "/friendship_acknowledgements/#{friendship_acknowledgement.id}"
      expect(response).to redirect_to(notifications_path)
    end
  end
end
