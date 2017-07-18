class SessionsController < ApplicationController
  def new
    redirect_to user_path(current_user.id) if signed_in?
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user_path(user)
    else
      render :new
    end
  end

  def auth
    auth_hash = request.env['omniauth.auth']
    user = User.find_by(email: auth_hash['info']['email'])
    @authorization = Authorization.find_by_provider_and_uid(
      auth_hash['provider'],
      auth_hash['uid']
    )
    if @authorization
      redirect_to user_path(user) if sign_in @authorization
    else
      user = User.new name: auth_hash['info']['name'],
                      email: auth_hash['info']['email']
      user.password = ' '
      user.authorizations.build provider: auth_hash['provider'],
                                uid: auth_hash['uid']
      if user.save!
        sign_in user
        redirect_to user_path(user)
      end
    end
  end

  def destroy
    sign_out
    redirect_to sign_in_path
  end
end
