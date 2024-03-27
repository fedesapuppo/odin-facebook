class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:destroy]

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: 'You commented this post!'
    elsif @comment.errors[:content].include?("can't be blank")
      redirect_to @post, alert: 'You cannot post an empty comment, write something!'
    else
      redirect_to @post, alert: 'There was an error commenting the post'
    end
  end

  def destroy
    if @comment.destroy
      redirect_to @post, notice: 'You eliminated the comment!'
    else
      redirect_to @post, alert: 'There was an error deleting the comment'
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
