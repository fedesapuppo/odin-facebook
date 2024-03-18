require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }
  let(:post_model) { create(:post, user:) }

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

  describe 'GET /posts/:id' do
    context 'when user is logged in' do
      before { sign_in user }

      it 'returns http success' do
        get "/posts/#{post_model.id}"
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to sign in page' do
        get "/posts/#{post_model.id}"
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

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
        get "/posts/#{post_model.id}/edit"
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to sign in page' do
        get "/posts/#{post_model.id}/edit"
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PATCH /posts/:id' do
    context 'when user is logged in' do
      before { sign_in user }

      it 'updates the post' do
        patch "/posts/#{post_model.id}", params: { post: { title: 'Updated Title' } }
        expect(response).to redirect_to(posts_path)
        expect(flash[:notice]).to eq('Post updated successfully')
        expect(post_model.reload.title).to eq('Updated Title')
      end

      it 'does not update the post with invalid attributes' do
        @post = Post.find(post_model.id)
        patch "/posts/#{post_model.id}", params: { post: { title: '' } }
        expect(flash[:alert]).to eq('Post update failed.')
      end
    end

    context 'when user is not logged in' do
      it 'redirects to sign in page' do
        patch "/posts/#{post_model.id}", params: { post: { title: 'Updated Title' } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'when user is logged in' do
      before { sign_in user }

      it 'deletes the post' do
        delete "/posts/#{post_model.id}"
        expect(Post.exists?(post_model.id)).to be_falsey
      end

      it 'redirects to posts index after deleting post' do
        delete "/posts/#{post_model.id}"
        expect(response).to redirect_to(posts_path)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to sign in page' do
        delete "/posts/#{post_model.id}"
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
