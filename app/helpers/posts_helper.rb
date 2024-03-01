module PostsHelper
  def liked_by?(post, _user_id)
    post.likes.exists?(user_id: current_user.id)
  end
end
