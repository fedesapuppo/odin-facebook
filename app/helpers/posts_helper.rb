module PostsHelper
  def liked_by?(post)
    post.likes.exists?(user: current_user)
  end

  def current_user_like(post)
    post.likes.find_by(user: current_user)
  end
end
