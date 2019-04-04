require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @post = @user.posts.build(post_name: "Test post title", introduction: "introduction to this post", sub_title: "subtitle", content: "Lorem ipsum", user_id: @user.id)
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "post name should be present" do
    @post.post_name = "   "
    assert_not @post.valid?
  end

  test "post name should be at most 80 characters" do
    @post.post_name = "a" * 81
    assert_not @post.valid?
  end

  test "subtitle should be present" do
    @post.sub_title = "   "
  	assert_not @post.valid?
  end

  test "subtitle should be at most 50 characters" do
    @post.sub_title = "a" * 51
    assert_not @post.valid?
  end

  test "content should be present" do
    @post.content = "   "
    assert_not @post.valid?
  end

  test "order should be most recent first" do
    assert_equal posts(:most_recent), Post.first
  end
end