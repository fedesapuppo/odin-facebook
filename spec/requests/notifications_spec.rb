require 'rails_helper'

RSpec.describe 'Notifications', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }

  describe 'GET /index' do
    context 'when user is logged in' do
      before { sign_in user }

      it 'returns http success' do
        get '/notifications/'
        expect(response).to have_http_status(:success)
      end

      it 'displays user name in navbar' do
        get '/notifications/'
        expect(response.body).to include("Signed in as #{user.name}")
      end
    end

    context 'when user is not logged in' do
      it 'redirects to sign in page' do
        get '/notifications/'
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
