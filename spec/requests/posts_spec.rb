require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }
  let(:post) { create(:post, user:) }

  describe 'GET /new' do
    context 'when user is logged in' do
      before { sign_in user }

      it 'returns http success' do
        get '/posts/new'
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to sign in page' do
        get '/posts/new'
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET /index' do
    context 'when user is logged in' do
      before { sign_in user }

      it 'returns http success' do
        get '/posts/'
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to sign in page' do
        get '/posts/'
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST /create' do
    context 'when user is logged in' do
      before { sign_in user }

      it 'creates a new post' do
        post '/posts', params: { post: { title: 'Test Title', content: 'Test Content' } }
        expect(response).to redirect_to(posts_path)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to sign in page' do
        post '/posts', params: { post: { title: 'Test Title', content: 'Test Content' } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET /edit' do
    context 'when user is logged in' do
      before { sign_in user }

      it 'returns http success' do
        get "/posts/#{post.id}/edit"
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to sign in page' do
        get "/posts/#{post.id}/edit"
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'when user is logged in' do
      before { sign_in user }

      it 'deletes the post' do
        delete "/posts/#{post.id}"
        expect(Post.exists?(post.id)).to be_falsey
      end

      it 'redirects to posts index after deleting post' do
        delete "/posts/#{post.id}"
        expect(response).to redirect_to(posts_path)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to sign in page' do
        delete "/posts/#{post.id}"
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
