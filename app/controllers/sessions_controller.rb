class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      login user
      user.generate_token
      remember(user)
      render user
    else
      render 'new'
    end
  end

  def destroy
    sign_out
  end
end
