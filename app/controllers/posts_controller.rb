class PostsController < ApplicationController
  include PostsHelper

  def index
    @posts = PostsService.new(current_user).friends_and_own_posts
    @likes = current_user.likes.where(post_id: @posts.pluck(:id))
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = 'Post created successfully'
      redirect_to posts_path
    else
      flash.now[:notice] = 'Post creation failed.'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = 'Post updated successfully'
      redirect_to posts_path
    else
      flash.now[:notice] = 'Post update failed.'
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find_by(id: params[:id])
    if @post
      @post.destroy
      flash[:notice] = 'Post deleted successfully'
    else
      flash[:notice] = 'Post not found'
    end
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
