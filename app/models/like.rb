class Like < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User'

  def self.update_likes_counter(post)
    counter = Like.where("post_id = #{post.id}").count
    post.likes_counter = counter
    post.save
  end
end
