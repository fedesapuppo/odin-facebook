module PostsHelper
  def liked_by?(post, _user_id)
    post.likes.exists?(user_id: current_user.id)
  end

  def current_user_like(post)
    post.likes.find_by(user_id: current_user.id)
  end
end
