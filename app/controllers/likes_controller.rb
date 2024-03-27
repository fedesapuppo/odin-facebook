class LikesController < ApplicationController
  before_action :set_post, only: %i[create destroy]

  def create
    @like = current_user.likes.find_or_initialize_by(post_id: @post.id)
    if @like.new_record?
      if @like.save
        if request.referer == post_url(@post)
          redirect_to @post, notice: 'Post liked!'
        else
          redirect_to posts_url, notice: 'Post liked!'
        end
      else
        flash[:alert] = 'Unable to like the post.'
        redirect_to @post
      end
    else
      flash[:alert] = 'You have already liked this post.'
      redirect_to @post
    end
  end

  def destroy
    @like = current_user.likes.find_by(post_id: @post.id)
    if @like
      @like.destroy
      if request.referer == post_url(@post)
        redirect_to @post, notice: 'Like removed.'
      else
        redirect_to posts_url, notice: 'Like removed.'
      end
    else
      flash[:alert] = 'Like not found.'
      redirect_to @post
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
