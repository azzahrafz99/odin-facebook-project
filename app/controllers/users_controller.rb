class UsersController < ApplicationController
  before_action :user, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def edit; end

  def show
    @user_posts = @user.posts.order(created_at: :desc)
  end

  def new; end

  def update
    if @user.update(user_params)
      if @user.valid?
        flash[:notice] = "Your profile has been updated!"
        redirect_to user_path
      end
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save && @user.authenticate(params[:user][:password])
      if @user.valid?
        UserMailer.welcome_email(@user).deliver_now
        redirect_to sign_in_path
      else
        render :new
      end
    end
  end

  def following
    @title = 'Following'
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password,
                                 :password_confirmation, :image)
  end

  def user
    @user = User.find(params[:id])
  end
end
