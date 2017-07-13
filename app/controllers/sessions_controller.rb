class SessionsController < ApplicationController
  def new
    redirect_to user_path(current_user.id) if signed_in?
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
    sign_out
    redirect_to sign_in_path, notice: "You have successfully signed out."
  end
end
