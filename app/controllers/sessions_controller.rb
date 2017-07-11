class SessionsController < ApplicationController
  def new
    if signed_in?
      redirect_to user_path(current_user.id)
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def destroy
      sign_out if signed_in?
      redirect_to sign_in_path
  end
end
