require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

class BlogPostsController < ApplicationController
  include BlogPostsHelper

  layout 'admin'

  before_action :logged_in_user

  def md_to_html
    markdown = request.body.read
    render plain: markdown(markdown) if markdown
  end

  def new
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

end
