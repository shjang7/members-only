# frozen_string_literal: true

require 'test_helper'

class PostsAuthorTest < ActionDispatch::IntegrationTest
  def setup
    user = users(:simon)
    @post = Post.new(content: 'Lorem ipsum', user_id: user.id)
    other_user = users(:suhyeon)
    @other_post = Post.new(content: 'Dollor amit', user_id: other_user.id)
  end

  test 'should see the author name when the post was written by current user' do
    get posts_path
    assert_select 'ul.posts' do
      assert_select 'li.post span.author',
                    text: @other_post.user.name.to_s, count: 0
      assert_select 'li.post span.author', text: @post.user.name.to_s, count: 0
    end
    log_in_as @post.user
    assert is_logged_in?
    get new_post_path
    post posts_path, params: { post: { content: @post.content,
                                       user_id: @post.user.id } }
    assert_redirected_to posts_path
    follow_redirect!
    assert_select 'ul.posts' do
      assert_select 'li.post span.author', text: @post.user.name.to_s, count: 1
    end
    delete logout_path
    assert_not is_logged_in?
    get posts_path
    assert_select 'ul.posts' do
      assert_select 'li.post span.author', text: @post.user.name.to_s, count: 0
    end
    log_in_as @other_post.user
    assert is_logged_in?
    post posts_path, params: { post: { content: @other_post.content,
                                       user_id: @other_post.user.id } }
    assert_redirected_to posts_path
    follow_redirect!
    assert_select 'ul.posts' do
      assert_select 'li.post span.author',
                    text: @other_post.user.name.to_s, count: 1
      assert_select 'li.post span.author', text: @post.user.name.to_s, count: 0
    end
  end
end
