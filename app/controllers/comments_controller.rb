class CommentsController < ApplicationController
  before_action :find_commentable

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.create(comment_params)
    @comment.save
    redirect_to post_path(@commentable)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_commentable
    @commentable = Post.find(params[:post_id])
  end
end
