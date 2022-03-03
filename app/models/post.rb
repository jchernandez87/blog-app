class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :author, class_name: 'User'
  validates :title, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def self.update_post_count(user)
    counter = Post.where("author_id = #{user.id}").count
    user.posts_counter = counter
    user.save
  end

  def self.recent_comments(post)
    Comment.where("post_id = #{post.id}").order(created_at: :desc).limit(5)
  end

  private

  def update_interactions
    @posts = Post.all
    @posts.each do |post|
      Comment.update_comments_counter(post)
    end
  end
end
