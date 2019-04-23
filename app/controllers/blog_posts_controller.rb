require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

class BlogPostsController < ApplicationController
  include BlogPostsHelper

  before_action :logged_in_user

  def md_to_html
    render plain: markdown(params[:markdown]) if params[:markdown]
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
