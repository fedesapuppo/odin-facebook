class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @friend_requests = FriendRequest.where(receiver_id: current_user, status: 'pending')
    @post = Post.new
  end  

  def index
    @friend_requests = FriendRequest.where(receiver_id: current_user, status: 'pending')
    @posts = PostsService.new(current_user).friends_and_own_posts
  end
  
  def create
    @friend_requests = FriendRequest.where(receiver_id: current_user, status: 'pending')
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Post created successfully"
      redirect_to posts_path
    else
      flash.now[:alert] = 'Post creation failed.'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end  

  def destroy
    @post = current_user.posts.find_by(id: params[:id])
    if @post
      @post.destroy
      flash[:notice] = "Post deleted successfully"
    else
      flash[:alert] = "Post not found"
    end
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
