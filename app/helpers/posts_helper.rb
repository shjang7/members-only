# frozen_string_literal: true

module PostsHelper
  def require_login
    redirect_to login_path unless signed_in?
  end
end
