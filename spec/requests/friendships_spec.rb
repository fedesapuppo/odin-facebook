require 'rails_helper'

RSpec.describe FriendshipsController, type: :request do
  include Devise::Test::IntegrationHelpers
  let(:user) { create(:user) }
  let!(:friend) { create(:user) }
  let!(:friendship) { create(:friendship, user:, friend:) }

  describe 'POST #create' do
    context 'when user is authenticated' do
      before { sign_in user }

      it 'creates a friendship' do
        expect do
          post '/friendships', params: { friend_id: friend.id }
        end.to change(Friendship, :count).by(1)
      end

      it 'redirects to friends path' do
        post '/friendships', params: { friend_id: friend.id }
        expect(response).to redirect_to(friends_path)
      end

      it 'sets a flash notice' do
        post '/friendships', params: { friend_id: friend.id }
        expect(flash[:notice]).to eq('Friendship created.')
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in page' do
        post '/friendships', params: { friend_id: friend.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is authenticated' do
      before { sign_in user }
      it 'destroys the friendship' do
        expect do
          delete "/friendships/#{friend.id}"
        end.to change(Friendship, :count).by(-1)
      end

      it 'redirects to friends path' do
        delete "/friendships/#{friend.id}"
        expect(response).to redirect_to(friends_path)
      end

      it 'sets a flash notice' do
        delete "/friendships/#{friend.id}"
        expect(flash[:notice]).to eq('Friend removed!')
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in page' do
        delete "/friendships/#{friend.id}"
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
