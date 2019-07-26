require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    user = users(:michael)
    @post = Post.new(content: "example content", user_id: user.id)
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "content should be present" do
    @post.content = "       "
    assert_not @post.valid?
  end
end
