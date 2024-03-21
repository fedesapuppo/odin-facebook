require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'validations' do
    it 'validates the presence of user_id' do
      user = create(:user)
      post = create(:post)
      like = Like.new(user_id: user.id, post_id: post.id)
      expect(like).to validate_presence_of(:user_id)
    end

    it 'validates uniqueness of user_id scoped to post_id' do
      user = create(:user)
      post = create(:post)
      create(:like, user:, post:)
      should validate_uniqueness_of(:user_id).scoped_to(:post_id)
    end
  end
end
