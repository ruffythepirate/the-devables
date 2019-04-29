class BlogPost < ApplicationRecord
  include BlogPostsHelper

  belongs_to :user

  default_scope -> {order(created_at: :desc)}

  def body_as_html
    markdown self.body
  end

  def ingress
    if self.body
      chunks = self.body
        .split("\n")
        .map {|s| s.strip}
        .filter{|s| !s.start_with?("#")}
        .filter{|s| !s.empty?}
      chunks.length > 0 ? chunks[0] : ""
    else
      self.body
    end
  end

  def publish
    update_columns(published: true, published_at: Time.zone.now)
  end

  def unpublish
    update_columns(published: false, published_at: nil)
  end

  validates :user_id, presence: true
  validates :title, presence: true
  validates :body, presence: true
end
