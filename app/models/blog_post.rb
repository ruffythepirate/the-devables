class BlogPost < ApplicationRecord
  include BlogPostsHelper

  belongs_to :user

  default_scope -> {order(created_at: :desc)}

  def body_as_html
    markdown self.body
  end

  validates :user_id, presence: true
  validates :title, presence: true
  validates :body, presence: true
end
