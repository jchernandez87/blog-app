class User < ApplicationRecord
  has_many :posts, foreign_key: 'users_id', dependent: :destroy
  has_many :likes, foreign_key: 'users_id', dependent: :destroy
  has_many :comments, foreign_key: 'users_id', dependent: :destroy
end
