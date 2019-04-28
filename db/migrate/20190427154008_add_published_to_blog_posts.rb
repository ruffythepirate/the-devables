class AddPublishedToBlogPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :blog_posts, :published, :boolean, default: false
    add_column :blog_posts, :published_at, :datetime
  end
end
