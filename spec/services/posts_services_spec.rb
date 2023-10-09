require "rails_helper"

RSpec.describe PostsService, type: :service do
  describe "#friends_and_own_posts" do
    let(:user) { create(:user) }
    let(:friend) { create(:user) }
    let(:friendship) { create(:friendship, user: user, friend: friend) }

    it "returns posts from the user and their friends" do
      own_post = create(:post, user: user)

      friendship

      friend_post = create(:post, user: friend)
      another_user_post = create(:post)

      posts = PostsService.new(user).friends_and_own_posts

      expect(posts).to include(own_post)
      expect(posts).to include(friend_post)
      expect(posts).not_to include(another_user_post)
    end
  end
end
