require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
  end

  test "login with valid information" do
    get login_path
    post login_path, params: { session: { email:    "example@railstutorial.org",
                                          password: "foobar" } }
    assert_response 200
  end
end
