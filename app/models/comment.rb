class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User'

  def self.update_comments_counter(post)
    counter = Comment.where("post_id = #{post.id}").count
    post.comments_counter = counter
    post.save
  end
end
