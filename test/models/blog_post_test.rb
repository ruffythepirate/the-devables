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

  test "Ingress ignores empty lines and headers" do
    post = BlogPost.new()
    post.body = """
    # Title

    The body starts here."""

    assert_equal "The body starts here.", post.ingress()
  end

  test "Ingress only takes the first paragraph" do
    post = BlogPost.new()
    post.body = """
    paragraph 1
    paragraph 2
    """

    assert_equal "paragraph 1", post.ingress()
  end
end
