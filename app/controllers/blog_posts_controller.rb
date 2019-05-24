class BlogPostsController < ApplicationController
  include BlogPostsHelper

  layout 'editor'

  before_action :logged_in_user

  def index
    @blog_posts = BlogPost.all
  end

  def md_to_html
    markdown = request.body.read
    render plain: markdown(markdown) if markdown
  end

  def new
    @blog_post = current_user.blog_posts.create()
  end

  def set_published
    @blog_post = current_user.blog_posts.find_by(id: params[:id])
    new_value =request.body.read == 'true'
    if @blog_post && @blog_post.published != new_value
      new_value ? @blog_post.publish : @blog_post.unpublish
    end
  end

  def get_user_post_list
    blog_posts = current_user.blog_posts
    render json: blog_posts
  end

  def destroy
    @blog_post = current_user.blog_posts.find_by(id: params[:id])
    if @blog_post
      @blog_post.destroy
      flash[:success] = "Post deleted"
      redirect_to blog_posts_url
    else
      flash[:danger] = "Failed"
    end
  end

  def update
    @blog_post = BlogPost.find params[:id]
    @blog_post.update_attributes!(blog_post_params)
  end

  def create
    blog_post = current_user.blog_posts.create(blog_post_params)
    blog_post.save!
    render json: blog_post
  end

  def edit
    @blog_post = BlogPost.find params[:id]
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
    params.require('blog_post').permit(:id, :title, :body)
  end
end
