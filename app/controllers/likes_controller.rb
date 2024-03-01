class LikesController < ApplicationController
  before_action :set_post, only: %i[create destroy]

  def create
    @like = current_user.likes.find_or_initialize_by(post_id: params[:post_id])
    if @like.new_record?
      if @like.save
        flash[:success] = 'Post liked.'
      else
        flash[:error] = 'Unable to like the post.'
      end
    else
      flash[:error] = 'You have already liked this post.'
    end
    redirect_to posts_path
  end

  def destroy
    @like = current_user.likes.find_by(post: @post)
    if @like
      @like.destroy
      flash[:success] = 'Like removed.'
    else
      flash[:error] = 'Unable to remove the like.'
    end
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
