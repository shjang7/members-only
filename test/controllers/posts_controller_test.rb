# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @post = Post.new(content: 'Lorem ipsum', user_id: @user.id)
  end

  test 'should inform login when not logged in to write a post' do
    get posts_path
    assert_not is_logged_in?
    get new_post_path
    assert_select 'a[href=?]', login_path
  end

  test 'should redirect posts path with valid post' do
    log_in_as @post.user
    assert is_logged_in?
    get new_post_path
    assert_template 'posts/new'
    post posts_path, params: { post: { content: ' ',
                                       user_id: @post.user.id } }
    assert_template 'posts/new'
    post posts_path, params: { post: { content: @post.content,
                                       user_id: @post.user.id } }
    assert_redirected_to posts_path
    follow_redirect!
    assert_template 'posts/index'
  end
end
