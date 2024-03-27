class LikesController < ApplicationController
  before_action :set_post, only: %i[create destroy]

  def create
    @like = current_user.likes.find_or_initialize_by(post_id: @post.id)
    return handle_existing_like if @like.persisted?
    return handle_successful_save if @like.save

    flash[:alert] = 'Unable to like the post.'
    redirect_to @post
  end

  def destroy
    @like = current_user.likes.find_by(post_id: @post.id)
    return handle_like_not_found unless @like

    @like.destroy
    handle_like_removed
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def handle_existing_like
    flash[:alert] = 'You have already liked this post.'
    redirect_to @post
  end

  def handle_successful_save
    redirect_to_referer_or_posts_url('Post liked!')
  end

  def redirect_to_referer_or_posts_url(notice_message)
    if request.referer == post_url(@post)
      redirect_to @post, notice: notice_message
    else
      redirect_to posts_url, notice: notice_message
    end
  end

  def handle_like_not_found
    flash[:alert] = 'Like not found.'
    redirect_to @post
  end

  def handle_like_removed
    redirect_to_referer_or_posts_url('Like removed.')
  end
end
