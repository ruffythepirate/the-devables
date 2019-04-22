class CreateBlogPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.string :body
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :blog_posts, [:user_id, :created_at], {order: {created_at: 'desc'}}
  end
end
