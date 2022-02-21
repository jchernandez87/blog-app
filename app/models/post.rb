class Post < ApplicationRecord
  has_many :posts
  has_many :likes
  blongs_to :user
end
