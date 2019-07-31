# frozen_string_literal: true

require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'should show right direct link according to login status' do
    get root_path
    assert_template 'posts/index'
    assert_select 'a[href=?]', root_path, count: 1
    assert_select 'a[href=?]', posts_path, count: 1
    assert_select 'a[href=?]', new_post_path, count: 2
    assert_select 'a[href=?]', signup_path, count: 1
    assert_select 'a[href=?]', login_path, count: 1
    assert_select 'a[href=?]', logout_path, count: 0
    log_in_as @user
    get root_path
    assert_select 'a[href=?]', signup_path, count: 0
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path, count: 1
  end
end
