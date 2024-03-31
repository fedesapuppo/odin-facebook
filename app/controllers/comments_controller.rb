class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @post, notice: 'You commented this post!'
    else
      redirect_to @post, alert: @comment.errors.messages[:content].to_sentence
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
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

  def comment_params
    params.require(:comment).permit(:content)
  end
end
