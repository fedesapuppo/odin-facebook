require 'rails_helper'

RSpec.describe 'Friends', type: :request do
  include Devise::Test::IntegrationHelpers

  describe 'GET /index' do
    context 'when user is logged in' do
      before do
        @user = create(:user)
        sign_in @user
        get '/friends/'
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'assigns the user\'s friends as @friends' do
        expect(controller.instance_variable_get(:@friends)).to eq(@user.friends)
      end

      it 'assigns the user\'s pending friend requests as @friend_requests' do
        expect(controller.instance_variable_get(:@friend_requests)).to eq(FriendRequest.where(receiver_id: @user, status: 'pending'))
      end

      it 'assigns the users not yet friends as @users_not_friends' do
        expect(controller.instance_variable_get(:@users_not_friends)).to eq(User.where.not(id: @user.friends).where.not(id: @user.id))
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the sign-in page' do
        get '/friends/'
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE /destroy' do
    let(:user) { create(:user) }
    let(:friend) { create(:user) }
    let!(:friendship) { create(:friendship, user:, friend:) }

    context 'when user is logged in' do
      before do
        sign_in user
        delete "/friends/#{friendship.id}"
      end

      it 'deletes the friendship' do
        expect(Friendship.exists?(friendship.id)).to be_falsey
      end

      it 'redirects to friends index page' do
        expect(response).to redirect_to(friends_path)
      end

      it 'displays a success message' do
        expect(flash[:notice]).to eq('Friendship removed successfully.')
      end
    end

    context 'when user is not logged in' do
      it 'does not delete the friendship' do
        expect {
          delete "/friends/#{friendship.id}"
        }.not_to change(Friendship, :count)
      end

      it 'redirects to the sign-in page' do
        delete "/friends/#{friendship.id}"
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
