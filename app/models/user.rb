class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id', class_name: 'Post'
  has_many :likes, foreign_key: 'author_id', class_name: 'Like'
  has_many :comments, foreign_key: 'author_id', class_name: 'Comment'

  def self.recent_posts(user)
    Post.joins(:author).where(author: { id: user.id }).order(created_at: :desc).limit(3)
  end
end
