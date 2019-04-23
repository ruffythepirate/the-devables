require 'test_helper'

class BlogPostsHelperTest < ActionView::TestCase
  test "renders html from markdown" do
    html = markdown("# My title")
    assert_equal html, "<h1>My title</h1>\n"
  end
end
