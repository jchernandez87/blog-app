class Post < ApplicationRecord
  has_many :posts, dependent: destroy
  has_many :likes, dependent: destroy
  blongs_to :author, class_name: 'User'
end
