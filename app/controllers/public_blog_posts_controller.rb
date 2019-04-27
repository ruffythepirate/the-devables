class PublicBlogPostsController < ApplicationController
  include BlogPostsHelper

  layout 'editor'

  def index
    @blog_posts = BlogPost.all
  end

  def show
    @blog_post = BlogPost.find(params[:id])
  end
end



