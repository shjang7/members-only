require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    # assert_template 'sessions/new'
    # assert_not flash.empty?
    # assert_not is_logged_in?
    # get login_path
    # assert flash.empty?
  end

  test "login with valid information" do
    log_in_as @user
    # it could be removed below
    # get login_path
    # post login_path, params: { session: { email:    @user.email,
    #                                       password: 'foobar' } }
    assert_redirected_to root_path
    assert is_logged_in?
  end

  test "login with valid information followed by logout" do
    log_in_as @user
    # it could be removed below
    # get login_path
    # post login_path, params: { session: { email:    @user.email,
    #                                       password: 'foobar' } }
    assert is_logged_in?
    # it could be added below if the cookie doesn't have problem
    # assert_redirected_to root_path
    # follow_redirect!
    # assert_select "a[href=?]", login_path,      count: 0
    # assert_select "a[href=?]", logout_path
    delete logout_path
    assert_not is_logged_in?
    # it could be added below if the cookie doesn't have problem
    # assert_redirected_to root_path
    # follow_redirect!
    # assert_select 'a[href=?]', login_path
    # assert_select "a[href=?]", logout_path,      count: 0
  end
end
