class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User'

  def self.update_post_count(user)
    counter = Post.where("author_id = #{user.id}").count
    user.posts_counter = counter
    user.save
  end

  def self.recent_comments(post)
    Comment.where("post_id = #{post.id}").order(created_at: :desc).limit(5)
  end
end
