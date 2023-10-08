class PostsService
  def initialize(user)
    @user = user
  end

  def friends_and_own_posts
    friend_ids = @user.friendships.pluck(:friend_id)
    Post.where(user_id: [@user.id, *friend_ids])
  end
end
