require 'rails_helper'

RSpec.describe 'Friends', type: :request do
  include Devise::Test::IntegrationHelpers
  describe 'GET /index' do
    it 'returns http success' do
      user = create(:user)
      sign_in user
      get '/friends/index'
      expect(response).to have_http_status(:success)
    end
  end
end
