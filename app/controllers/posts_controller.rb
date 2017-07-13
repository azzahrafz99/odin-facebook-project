class PostsController < ApplicationController
  before_action :search
  before_action :restrict_to_signed_in, only: [:new, :create, :index]
  before_action :post, only: [:show, :destroy, :like, :dislike, :edit, :update]

  def new
    @post = Post.new
  end

  def show
    @post_comments = @post.comments.order(created_at: :desc)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.valid?
      if @post.save
        flash[:notice] = 'Your post has been posted!'
        redirect_to posts_path
      end
    else
      render :new
    end
  end

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def edit; end

  def update
    @post.update(post_params)
    if @post.valid?
      redirect_to posts_path, notice: "Your post has been updated!"
    else
      render :edit
    end
  end

  def destroy
    redirect_to current_user if @post.destroy
  end

  def like
    redirect_to posts_path(@post) if @post.liked_by current_user
  end

  def dislike
    redirect_to posts_path(@post) if @post.disliked_by current_user
  end

  def routing
    render file: "#{Rails.root}/public/404.html", status: 404, layout: false
  end

  private

  def search
    @results = User.all
    @results = @results.where(username: params[:search])
  end

  def post_params
    params.require(:post).permit(:title, :content, :image)
  end

  def post
    @post = Post.find(params[:id])
  end
end
