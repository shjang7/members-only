# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include PostsHelper

  helper_method :signed_in?, :current_user, :current_user?
end
