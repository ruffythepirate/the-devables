require 'test_helper'

class BlogPostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "post to md_to_html should convert the body to html." do
    log_in_as(@user)
    post '/api/blog-post/md-to-html', params: '# My title', xhr: true

    assert_equal "<h1>My title</h1>\n", @response.body
  end

  test "post to md_to_html requires logged in" do
    post '/api/blog-post/md-to-html'
    assert_response :redirect

    log_in_as(@user)

    post '/api/blog-post/md-to-html'
    assert_response :success
  end

  test "new requires logged in" do
    get blog_posts_new_url
    assert_response :redirect

    log_in_as(@user)

    get blog_posts_new_url
    assert_response :success
    assert_template 'blog_posts/new'
   end
end
