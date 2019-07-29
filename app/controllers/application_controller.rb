class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include PostsHelper

  helper_method :is_signed_in?, :current_user
end
