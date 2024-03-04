module PostsHelper
  def liked_by?(post, _user_id)
    post.likes.exists?(user: current_user)
  end

  def current_user_like(post)
    post.likes.find_by(user: current_user)
  end
end
