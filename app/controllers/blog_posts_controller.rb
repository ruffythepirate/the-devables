require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

class BlogPostsController < ApplicationController
  include BlogPostsHelper

  layout 'editor'

  before_action :logged_in_user

  def md_to_html
    markdown = request.body.read
    render plain: markdown(markdown) if markdown
  end

  def new
  end

  def create
    blog_post = current_user.blog_posts.create(blog_post_params)

    render json: blog_post
  end

  def edit
  end

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  private
  def blog_post_params
    params.require('blog_post').permit(:title, :body)
  end
end
