class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # Logs in the given user.
  def sign_in(user)
    session[:user_id] = user.id
    current_user
  end

  def remember(user)
    # cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    if session[:user_id]
      user_id = session[:user_id]
      @current_user ||= User.find_by(id: user_id)
      # @current_user if !current_user.nil?
    else
      remember_token = cookies[:remember_token]
      @current_user ||= User.find_by(remember_token: remember_token)
      # return current_user
    end
  end

  # Logs out the current user.
  def sign_out
    # cookies.delete(:user_id)
    cookies.delete(:remember_token)
    session.delete(:user_id)
    @current_user = nil
  end

  # Check log in status
  def is_signed_in?
    !current_user.nil?
  end

  helper_method :is_signed_in?, :current_user
end
