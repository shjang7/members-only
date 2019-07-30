# frozen_string_literal: true

module PostsHelper
  def require_login
    redirect_to login_path unless is_signed_in?
  end
end
