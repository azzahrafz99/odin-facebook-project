class PostsController < ApplicationController
  before_action :restrict_to_signed_in, only: [:new, :create, :index]

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @post_comments = @post.comments.order(created_at: :desc)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
        redirect_to posts_path
    end
  end

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def destroy
    @post = Post.find(params[:id]).destroy
    redirect_to current_user
  end

  private

    def post_params
        params.require(:post).permit(:title, :content, :image)
    end
end
