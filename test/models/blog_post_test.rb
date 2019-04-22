require 'test_helper'

class BlogPostTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @blog_post = @user.blog_posts.build(title: 'title', body: 'body', user_id: @user.id)
  end

  test "Should default be valid" do
    assert @blog_post.valid?
  end

  test "Requires a creator" do
    @blog_post.user_id = nil
    assert_not @blog_post.valid?
  end

  test "Requires a title" do
    @blog_post.title = nil
    assert_not @blog_post.valid?
  end

  test "Requires a body" do
    @blog_post.body = nil
    assert_not @blog_post.valid?
  end

  test "Order should be most recent first" do
    assert_equal blog_posts(:most_recent), BlogPost.first
  end
end
