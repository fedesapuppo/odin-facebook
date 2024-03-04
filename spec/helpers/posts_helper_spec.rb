require 'rails_helper'

RSpec.describe PostsHelper, type: :helper do
  let(:current_user) { create(:user) }
  let(:post) { create(:post) }

  before do
    allow(helper).to receive(:current_user).and_return(current_user)
  end

  describe 'liked_by?' do
    context 'liked by current logged in user' do
      it 'returns true' do
        # setup
        post.likes.create(user: current_user)
        # excecution
        result = helper.liked_by?(post)
        # asertion
        expect(result).to be_truthy
      end
    end

    context 'not liked by current logged in user' do
      it 'returns false' do
        expect(helper.liked_by?(post)).to be_falsey
      end
    end
  end
end
