class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = PostsService.new(current_user).friends_and_own_posts
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created successfully"
    else
      flash[:error] = "Error creating the post"
    end
    redirect_to posts_path
  end

  def destroy
    @post = current_user.posts.find_by(id: params[:id])
    if @post
      @post.destroy
      flash[:success] = "Post deleted successfully"
    else
      flash[:error] = "Post not found"
    end
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
