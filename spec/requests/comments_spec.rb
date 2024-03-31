require 'rails_helper'
RSpec.describe 'Comments', type: :request do
  include Devise::Test::IntegrationHelpers
  describe 'POST /posts/:post_id/comments' do
    it 'creates a new comment with valid attributes' do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, user:)
      valid_attributes = FactoryBot.attributes_for(:comment)
      sign_in user

      expect do
        post "/posts/#{post.id}/comments", params: { comment: valid_attributes }
      end.to change(Comment, :count).by(1)

      expect(response).to redirect_to(post)
      expect(flash[:notice]).to eq('You commented this post!')
    end

    it 'does not create a new empty comment and gives appropriate feedback to the user' do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, user:)
      invalid_attributes = { content: '' }
      sign_in user

      expect do
        post "/posts/#{post.id}/comments", params: { comment: invalid_attributes }
      end.to_not change(Comment, :count)

      expect(response).to redirect_to(post)
      expect(flash[:alert]).to eq('You cannot post an empty comment, write something!')
    end
  end

  describe 'DELETE /posts/:post_id/comments/:id' do
    it 'destroys the specified comment' do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, user:)
      comment = FactoryBot.create(:comment, post:, user:)
      sign_in user

      expect do
        delete "/posts/#{post.id}/comments/#{comment.id}"
      end.to change(Comment, :count).by(-1)

      expect(response).to redirect_to(post)
      expect(flash[:notice]).to eq('You eliminated the comment!')
    end
  end
end
