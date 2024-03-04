require 'rails_helper'

RSpec.describe PostsHelper, type: :helper do
  let(:current_user) { create(:user) }

  before do
    @post = create(:post)
    @post.likes.create(user: current_user)
    @like = @post.likes.find_by(user: current_user)
    allow(helper).to receive(:current_user).and_return(current_user)
  end

  describe 'liked_by?' do
    it 'returns true when liked by current logged in user' do
      expect(helper.liked_by?(@post)).to be_truthy
    end

    it 'returns false when not liked by current logged in user' do
      expect(!helper.liked_by?(@post)).to be_falsey
    end
  end

  describe 'current_user_like' do
    it 'returns the like object for the current user if the post is liked by the current user' do
      expect(helper.current_user_like(@post)).to eq(@like)
    end
  end
end
